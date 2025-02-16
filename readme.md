#how to use stow

.config/nvim       => nvim/.config/nvim
.config/alacritty  => alacritty/.config/alacritty
.zshrc             => zsh/.zshrc

command: 
    mv .config/nvim /dotfiles/nvim/.config/

    dir(
        dotfiles/
          nvim/
            .config/
                nvim/
                    init.lua
                    lua/
    )
    cd dotfiles 
        stow nvim (done)
        stow tmux (done)

