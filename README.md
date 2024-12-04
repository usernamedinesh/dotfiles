# dotfiles

This repository contains my dotfiles, configuration files, and setup scripts for a variety of tools I use daily, including tmux, nvim, zsh, i3, alacritty, and more. The goal is to keep my development environment consistent across different machines and easily shareable.
Tools Configured

This repository includes the following tool configurations:

    Tmux: Terminal multiplexer configuration for managing multiple terminal sessions.
    Neovim (nvim): Configuration for a highly customizable text editor.
    Zsh: Shell configuration with plugins and themes.
    i3: Window manager configuration for a tiling window setup.
    Alacritty: Fast and GPU-accelerated terminal emulator configuration.
    Others: Configuration for additional tools such as Git, Vim, and other utilities.

Installation

1. Clone the repository

Clone this repository to your home directory (or wherever you prefer):

git clone https://github.com/usernamedinesh/dotfiles.git ~/dotfiles

2. Symlink the dotfiles

Create symbolic links from the repository to your home directory. This can be done manually, or you can use a setup script.

For example, to link tmux and nvim:

ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.zshrc ~/.zshrc

Alternatively, run the provided setup script to automatically symlink all dotfiles:

cd ~/dotfiles
./install.sh

3. Install dependencies

Depending on your configuration, you may need to install the following tools:

    Tmux: sudo apt install tmux (Debian/Ubuntu)
    Neovim: sudo apt install neovim (Debian/Ubuntu)
    Zsh: sudo apt install zsh (Debian/Ubuntu)
    i3: sudo apt install i3 (Debian/Ubuntu)
    Alacritty: sudo apt install alacritty (Debian/Ubuntu)

You might also need to install additional plugins or software based on your setup. These dependencies are usually managed by package managers like apt, brew, or yay (for Arch-based systems).

For plugins like zsh plugins, vim/neovim plugins, or tmux plugins, refer to the corresponding documentation files (e.g., .zshrc, .vimrc, etc.) for installation steps. 4. Setup i3 and Alacritty

If you are using i3 and Alacritty, you may want to make sure to adjust the following configuration files:

    ~/.config/i3/config for i3 window manager settings.
    ~/.config/alacritty/alacritty.yml for Alacritty terminal settings.

Refer to these files for more customization options.
Features

    Tmux: Includes a custom status line, keybindings, and split pane layouts for efficient window management.
    Neovim: Includes plugins for LSP (Language Server Protocol), auto-completion, file navigation, Git integration, and custom keybindings.
    Zsh: Uses zplug for plugin management, zsh-users/zsh-autosuggestions, and zsh-users/zsh-syntax-highlighting.
    i3: Configured for a simple yet powerful tiling window manager experience.
    Alacritty: Configured with a custom color scheme, font settings, and performance tweaks.

Customization

Feel free to fork and customize these dotfiles to your preferences. To make changes:

    Tmux: Edit .tmux.conf.
    Neovim: Edit .vimrc or init.vim for Neovim-specific settings.
    Zsh: Modify .zshrc for shell preferences, plugins, and themes.
    i3: Modify .config/i3/config to add shortcuts, workspaces, and more.
    Alacritty: Customize the alacritty.yml file for your terminal appearance.

Contributions

If you find any bugs, improvements, or new configurations, feel free to open an issue or submit a pull request!
License

This repository is licensed under the MIT License. See the LICENSE file for more details.
