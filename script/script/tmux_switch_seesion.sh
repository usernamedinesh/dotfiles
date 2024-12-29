#!/usr/bin/env bash

# List all tmux sessions and let fzf handle the selection
# show preview
# selected=$(tmux list-sessions -F "#{session_name}: #{session_windows} windows, created #{session_created}" | fzf --preview 'tmux list-windows -t {1}' --preview-window=up:wrap)
selected=$(tmux list-sessions -F "#{session_name}: #{session_windows} windows, created #{session_created}" | fzf)

# Exit if no session is selected
if [[ -z $selected ]]; then
    exit 0
fi

# Extract the session name (everything before the first ":")
session_name=$(echo "$selected" | cut -d':' -f1)

# Attach to the selected session
tmux attach-session -t "$session_name"
