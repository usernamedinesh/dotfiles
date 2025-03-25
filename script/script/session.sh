#!/usr/bin/env bash

# Get the current username
USERNAME=$(whoami)

# Define session names
DEFAULT_SESSION="${USERNAME}"
SESSION_PREFIX="term"

# Function to check if a session exists
session_exists() {
    tmux has-session -t "$1" 2>/dev/null
}

# If no session exists, start with DEFAULT_SESSION
if ! session_exists "$DEFAULT_SESSION"; then
    tmux new-session -s "$DEFAULT_SESSION"
    exit 0
fi

# Try creating term2, term3, term4...
for i in {1..3}; do
    NEW_SESSION="${SESSION_PREFIX}${i}"
    if ! session_exists "$NEW_SESSION"; then
        tmux new-session -s "$NEW_SESSION"
        exit 0
    fi
done

echo "Error: Maximum number of sessions (home, term1, term2, term3) reached!"
exit 1

