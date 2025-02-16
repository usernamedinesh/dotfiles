#!/usr/bin/env bash

# Get the session creation time in seconds since the epoch
session_created=$(tmux display -p -F "#{session_created}")

# Get the current time in seconds since the epoch
current_time=$(date +%s)

# Calculate the elapsed time in seconds
elapsed_seconds=$((current_time - session_created))

# Calculate days, hours, minutes, and seconds
days=$((elapsed_seconds / 86400))
hours=$(( (elapsed_seconds % 86400) / 3600 ))
minutes=$(( (elapsed_seconds % 3600) / 60 ))
seconds=$(( elapsed_seconds % 60 ))

# Display the elapsed time
printf "%dd %02dh %02dm %02ds" $days $hours $minutes $seconds
