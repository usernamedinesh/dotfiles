#!/bin/zsh

ZSH_THEME="robbyrussell"

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

export EDITOR=nvim
export LANG=en_IN.UTF-8
export LC_ALL=en_IN.UTF-8
export PATH=$PATH:/run/current-system/sw/bin
export LD_LIBRARY_PATH=/run/current-system/sw/bin/libnetcfg:$LD_LIBRARY_PATH
# export TERM=xterm-256color

export MANPATH=$MANPATH:$HOME/man

# Aliases
alias vim='nvim'
alias vi='nvim'
alias ..='cd ..'
alias so='source'
# alias tls='tmux ls'
alias la='ls -a'
alias ll='ls -la'
alias e='exit'
alias home='cd ~'
alias c='cd'
alias clr='clear'
alias h='home'
alias gs='git status'
alias ga='git add .'
alias gj='git commit'
alias dps='sudo docker ps -a'
alias dim='sudo docker images'
alias ncon='cd /etc/nixos'
alias gc='nix-shell /home/dinesh/script/shell.nix'

alias zen="./bin/zen"

alias ts="/home/dinesh/script/tmux_sessionaizer.sh"
alias tm="/home/dinesh/script/tm_session.sh"
alias tf="/home/dinesh/script/test.sh"
alias tx='tmux new-session -s $(whoami)'
alias ta='tmux a'
alias s="./script/pick_session.sh"
bindkey '^S' run_pic_session

run_pic_session() {
    ./script/pick_session.sh
}

#show branch
get_git_branch() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)
        echo "%F{red}($git_branch)%f"
    fi
}

# Define colors
RED='%F{red}'
GREEN='%F{green}'
YELLOW='%F{yellow}'
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

# Customize the prompt to show ✗ everywhere except home directory
export PS1="${RED}🡪  ${GREEN}\$(get_prompt_dir)${YELLOW}\$(get_git_branch)${RESET}\$(if [ \"\$PWD\" != \"\$HOME\" ]; then echo \" ${RED}✗\"; fi) "
# PROMPT='%F{green}➜ %F{blue}%~ %f$ ' # Custom prompt symbol and colors

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH=$PATH:~/.npm-global/bin

new_tmux_session() {
    if [ -z "$1" ]; then
        echo "Usage: new_tmux_session <session_name>"
        return 1
    fi
    tmux new-session -d -s "$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S')" > ~/.tmux/sessions/"$1"_created.txt
    tmux attach-session -t "$1"
}

function auto_source_zshrc() {
    local last_modified=$(stat -c %Y ~/.zshrc)
    while true; do
        sleep 2
        local current_modified=$(stat -c %Y ~/.zshrc)
        if [[ $current_modified != $last_modified ]]; then
            source ~/.zshrc
            echo ".zshrc reloaded at $(date)"
            last_modified=$current_modified
        fi
    done
}
