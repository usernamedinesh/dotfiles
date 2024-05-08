#!/bin/bash

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias vi='nvim'

nvim() {
	# Check if the command matches 'nvim . -t'
	if [[ "$1" == "." && "$2" == "-t" ]]; then
		~/.dotfiles/cht.sh
	else
		# If the command doesn't match, execute Neovim with the provided arguments
		command nvim "$@"
	fi
}
# Prompt
PS1='[\u@\h \W]\$ '
#set wallpaper like this
# feh --bg-fill /home/dinesh/wallpaper/img4.jpg &
# Go Environment
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export EDITOR=nvim

# Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
source $ZSH/oh-my-zsh.sh

open_in_nvim() {
	local session_name=$1
	local file=$2
	if [ -n "$session_name" ]; then
		# Create a new session
		tmux new-session -d -s "$session_name"
		# Attach Neovim to the session and open the file
		tmux attach-session -t "$session_name" \; send-keys "cd $(dirname "$file") && nvim $(basename "$file")" Enter
	else
		cd "$(dirname "$file")" && nvim "$(basename "$file")"
	fi
}

NVIM() {
	allowed_folders=("Desktop" "server" ".dotfiles" "personal" "Documents")
	excluded_items=("node_modules" "cargo" "bin" "hello_cargo" "target" ".gitignore" ".git" "build")

	exclude_conditions=()
	for item in "${excluded_items[@]}"; do
		exclude_conditions+=("-path" "*/$item*" "-prune" "-o")
	done
	exclude_conditions=("${exclude_conditions[@]::${#exclude_conditions[@]}-1}")

	selected_file=$(find "${allowed_folders[@]}" \( "${exclude_conditions[@]}" \) -false -o -type f | fzf)
	if [ -z "$selected_file" ]; then
		return
	fi

	# Check if running inside a tmux session
	if [ -n "$TMUX" ]; then
		nvim "$selected_file"
	else
		echo -n "Enter session name: "
		read session_name
		open_in_nvim "$session_name" "$selected_file"
	fi
}

# Bind the function to the Alt+S tmux open
bindkey -s '^[s' 'NVIM\n'
