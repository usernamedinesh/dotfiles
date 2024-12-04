#!/bin/zsh
# eval "$(starship init zsh)"

# . "$HOME/.cargo/env"
# Aliases
alias vim='nvim'
alias vi='nvim'
alias ..='cd ..'
alias tls='tmux ls'
alias la='ls -a'
alias e='exit'
alias home='cd ~'
alias clr='clear'
alias h='home'
alias dps='sudo docker ps'
alias dim='sudo docker images'
alias ncon='cd /etc/nixos'
alias gc='nix-shell /home/dev/script/shell.nix'

# unalias runcpp 2>/dev/null
runcpp() {
    filename=$(basename -- "$1")   # Get the file name from the path
    executable="${filename%.cpp}"  # Remove the .cpp extension for the executable name
    g++ "$1" -o "$executable" && (./"$executable"; echo)
}


export EDITOR=nvim
export LANG=en_IN.UTF-8
export VISUAL=nvim

#set wallpaper like this
# feh --bg-fill /home/dinesh/wallpaper/img4.jpg &

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
    allowed_folders=("/home/dinesh/one/Desktop/client-project" "/home/dinesh/one/dsa_cpp" "/home/dinesh/one/project" "/home/dinesh/.config/i3/" "/home/dinesh/.zshrc" "/home/dinesh/.tmux.conf" "/home/dinesh/.config/nvim" "/home/dinesh/lang/")

    # List of excluded directories and files
    excluded_items=("build" "node_modules" ".git" "go" ".gitignore" ".env" "package.json")

    # Build exclude conditions for both files and directories
    exclude_conditions=()
    for item in "${excluded_items[@]}"; do
        exclude_conditions+=("-name" "$item" "-o")
    done

    # Remove the trailing '-o'
    exclude_conditions=("${exclude_conditions[@]::${#exclude_conditions[@]}-1}")

    # Use 'find' to search allowed folders excluding specific items
    selected_file=$(find "${allowed_folders[@]}" \( "${exclude_conditions[@]}" \) -prune -o -type f -print | fzf)

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
# NVIM() {
#     allowed_folders=("/home/dinesh/one/Desktop/client-project" "/home/dinesh/one/dsa_cpp" "/home/dinesh/one/project" "/home/dinesh/.config/i3/" "/home/dinesh/.zshrc" "/home/dinesh/.tmux.conf" "/home/dinesh/.config/nvim")
#     excluded_items=("node_modules" ".gitignore" ".git" "go")
#
#     exclude_conditions=()
#     for item in "${excluded_items[@]}"; do
#         exclude_conditions+=("-path" "*/$item*" "-prune" "-o")
#     done
#     exclude_conditions=("${exclude_conditions[@]::${#exclude_conditions[@]}-1}")
#
#     selected_file=$(find "${allowed_folders[@]}" \( "${exclude_conditions[@]}" \) -false -o -type f | fzf)
#     if [ -z "$selected_file" ]; then
#         return
#     fi
#
#     # Check if running inside a tmux session
#     if [ -n "$TMUX" ]; then
#         nvim "$selected_file"
#     else
#         echo -n "Enter session name: "
#         read session_name
#         open_in_nvim "$session_name" "$selected_file"
#     fi
# }

# Bind the function to the Alt+S tmux open
# bindkey -s '^[c' 'NVIM\n'
bindkey -s '\et' 'NVIM\n'



#tmux creating session
tmux_session() {
    # If the first argument is "ls", list tmux sessions
    if [ "$1" = "ls" ]; then
        command tmux ls
        return
    fi

    # Determine session name
    local session_name="${1:-$(basename "$PWD")}"

    # If the session exists, attach to it; otherwise, create a new session
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
    else
        tmux new-session -s "$session_name"
    fi
}
alias tmux='tmux_session'

#shwoing branch
get_git_branch() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)
        echo "%F{red}($git_branch)%f"
    fi
}
# Customize the prompt to include the Git branch

# Define colors
RED='%F{red}'
GREEN='%F{green}'
YELLOW='%F{yellow}'
BLUE='%F{blue}'
RESET='%f'

# Define colors
RED='%F{red}'
GREEN='%F{green}'
BLUE='%F{blue}'
RESET='%f'

# Function to get current directory or ~ if in home
get_prompt_dir() {
    if [ "$PWD" = "$HOME" ]; then
        echo "~"
    else
        basename "$PWD"
    fi
}

export PS1="${BLUE}➜  ${GREEN}\$(get_prompt_dir)${YELLOW}\$(get_git_branch)${RESET} "
