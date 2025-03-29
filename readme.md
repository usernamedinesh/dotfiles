#how to use stow

dotfiles/
├── nvim/
│   └── .config/
│       └── nvim/
│           ├── init.lua
│           └── lua/
├── alacritty/
│   └── .config/
│       └── alacritty/
├── zsh/
│   └── .zshrc
└── tmux/
    └── .tmux.conf

# Move existing config files (if necessary)
mv ~/.config/nvim /dotfiles/nvim/.config/
mv ~/.config/alacritty /dotfiles/alacritty/.config/
mv ~/.zshrc /dotfiles/zsh/.zshrc

# Navigate to the dotfiles directory
cd /path/to/dotfiles

# Install stow if necessary (for Ubuntu/Debian)
sudo apt install stow

# Stow configuration files
stow nvim
stow zsh
stow alacritty
stow tmux  # Optional, if you have a tmux config
