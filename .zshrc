
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'

# Prompt
PS1='[\u@\h \W]\$ '

# Go Environment
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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
        # If no session name is provided, open Neovim directly
        cd "$(dirname "$file")" && nvim "$(basename "$file")"
    fi
}
select_file_and_open_in_nvim() {
    local selected_file=$(find . -type f \( -not -path "*/.config/*" -not -path "*/.vim/*" -not -path "*/.tmux/*" -not -path "*/.oh-my-zsh/*" -not -path "*/.themes/*" -not -path "*/.git/*" -not -path "*/target/*" -not -path "*/pkg/*" -not -path "*/.config/go/*" -not -path "*/MongoDB Compass/*" -and -not -path "*/Postman/*" -and -not -path "*/Code - OSS/*" -and -not -path "*/Code/*" -and -not -path "*/.vscode-oss/*" -and -not -path "*/.var/*" -and -not -path "*/.mozilla/*" -and -not -path "*/.mongodb/*" -and -not -path "*/.icons/*" -and -not -path "*/.codeium/*" -and -not -path "*/.npm/*" -and -not -path "*/.cargo/*" -and -not -path "*/.cache/*" -and -not -path "*/.local/*" -and -not -path "*/Downloads/*" -and -not -path "*/Pictures/*" -and -not -path "*/node_modules/*" -and -not -path "*/Videos/*" \) | fzf)

    if [ -z "$selected_file" ]; then
        return
    fi

    echo -n "Session name: "
    read session_name

    open_in_nvim "$session_name" "$selected_file"
}

# Bind the function to the Alt+S key combination
bindkey -s '^[s' 'select_file_and_open_in_nvim\n'

# Automatically source .zshrc when it's modified
autoload -U add-zsh-hook
zshrc_modified() {
    source ~/.zshrc
}
add-zsh-hook -Uz chpwd zshrc_modified
