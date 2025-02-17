#!/usr/bin/env bash

# File to store the session names
SESSION_FILE="$HOME/script/session_name"

# Ensure the session file exists
touch "$SESSION_FILE"

# Read session names from the file
AVAILABLE_SESSIONS=($(cat "$SESSION_FILE"))

# Add "Enter a new session" option
AVAILABLE_SESSIONS+=("Enter a new session")

# Get a list of currently running TMUX sessions
RUNNING_SESSIONS=$(tmux list-sessions 2>/dev/null | awk -F: '{print $1}')

# Display the options vertically with letters
echo "Select a TMUX session to open:"
for ((i=0; i<${#AVAILABLE_SESSIONS[@]}; i++)); do
    # Convert index to corresponding letter (a, b, c, ...)
    LETTER=$(printf "\\$(printf '%03o' $((97 + i)))")
    SESSION_NAME="${AVAILABLE_SESSIONS[$i]}"
    
    # Check if the session is running
    if echo "$RUNNING_SESSIONS" | grep -wq "$SESSION_NAME"; then
        echo "$LETTER) $SESSION_NAME (running..)"
    else
        echo "$LETTER) $SESSION_NAME"
    fi
done

# Read user input
read -rp "Enter your choice (a, b, c, ...): " CHOICE

# Convert the letter to an index
INDEX=$(($(printf "%d" "'$CHOICE") - 97))

# Validate the index
if [[ $INDEX -ge 0 && $INDEX -lt ${#AVAILABLE_SESSIONS[@]} ]]; then
    SESSION="${AVAILABLE_SESSIONS[$INDEX]}"
    if [[ "$SESSION" != "Enter a new session" ]]; then
        # Check if the session already exists
        if tmux has-session -t "$SESSION" 2>/dev/null; then
            # If inside a TMUX session, switch to the target session
            if [[ -n "$TMUX" ]]; then
                echo "Switching to existing session: $SESSION"
                tmux switch-client -t "$SESSION"
            else
                # If not inside a TMUX session, attach to the target session
                echo "Attaching to existing session: $SESSION"
                tmux attach-session -t "$SESSION"
            fi
        else
            # If the session does not exist, create it
            if [[ -n "$TMUX" ]]; then
                echo "Creating a new session in the background: $SESSION"
                tmux new-session -d -s "$SESSION"  # Create in the background
                tmux switch-client -t "$SESSION"   # Switch to the new session
            else
                echo "Creating and attaching to new session: $SESSION"
                tmux new-session -s "$SESSION"
            fi
        fi
    else
        read -rp "Enter a new session name: " NEW_SESSION
        if [[ -n "$NEW_SESSION" ]]; then
            # Add new session name to file and start session
            echo "$NEW_SESSION" >> "$SESSION_FILE"
            if [[ -n "$TMUX" ]]; then
                echo "Creating a new session in the background: $NEW_SESSION"
                tmux new-session -d -s "$NEW_SESSION"  # Create in the background
                tmux switch-client -t "$NEW_SESSION"   # Switch to the new session
            else
                echo "Creating and attaching to new session: $NEW_SESSION"
                tmux new-session -s "$NEW_SESSION"
            fi
        else
            echo "Invalid session name."
        fi
    fi
else
    echo "Invalid choice. Please try again."
fi
