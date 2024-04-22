#!/usr/bin/env bash

# Prompt the user for a session name
echo -n "Session name: "
read session_name

# Create a new TMUX session with the provided name and launch Neovim
tmux new-session -s "$session_name" -d "nvim ."
tmux attach-session -t "$session_name"
