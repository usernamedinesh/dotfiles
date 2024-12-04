{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
#      (import /etc/nixos/modules/neovim.nix)
    ];

#    nixpkgs.overlays = [
#   	 (import /etc/nixos/modules/neovim.nix)  
#  ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];
 

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  xdg.portal.enable = true;
   xdg.portal.extraPortals = [            # Specify the portal implementation
    pkgs.xdg-desktop-portal-gtk          # Use GTK implementation
  ];

fileSystems."/home/dinesh/four" = {
    device = "/dev/sda4";
    fsType = "ntfs"; # Replace with your filesystem type
    options = [ "defaults" ];
  };
fileSystems."/home/dinesh/three" = {
    device = "/dev/sda3";
    fsType = "ntfs"; # Replace with your filesystem type
    options = [ "defaults" ];
  };
  fileSystems."/home/dinesh/one" = {
    device = "/dev/sda1";
    fsType = "ntfs"; # Replace with your filesystem type
    options = [ "defaults" ];
  };
  fileSystems."/home/dinesh/two" = {
    device = "/dev/sda2";
    fsType = "ntfs"; # Replace with your filesystem type
    options = [ "defaults" ];
  };

  #enable i3
  services.xserver = {
	enable = true;
	desktopManager = {
		xterm.enable = true;
	};
	windowManager.i3 = {
		enable = true;
		extraPackages = with pkgs;[];
	};
  };
  services.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

#enable audio
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.support32Bit = true;
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.package = pkgs.bluez;
  nixpkgs.config.pulseaudio = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override {fonts = ["Meslo"];})
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["Meslo LG M Regular Nerd Font Complete Mono"];
        serif = ["Noto Serif" "Source Han Serif"];
        sansSerif = ["Noto Sans" "Source Han Sans"];
      };
    };
  };


#enable zsh and oh my zsh
 users.defaultUserShell=pkgs.zsh; 


programs = {
   zsh = {
      enable = true;
      autosuggestions.enable = true;
      zsh-autoenv.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
         enable = true;
         theme = "robbyrussell";
         plugins = [
           "git"
           "npm"
           "history"
           "node"
           "rust"
           "deno"
         ];
      };
   };
};

services.flatpak.enable = true;
virtualisation.docker.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dinesh = {
    isNormalUser = true;
    description = "dinesh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config = {
	allowUnfree = true;
	allowInsecure = true;
  };


  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  wget
	#utility
	unzip
	feh
	zip
	rofi
	waybar
#	i3blocks
#	jq
	pamixer
	brightnessctl
	zsh
	oh-my-zsh
	bluez
	blueman
	maim
	pipewire
	xclip
	picom

	#software
	firefox
	git
	nautilus
	vlc
	alacritty
	wezterm
	
	#dev_tools
	neovim
	ripgrep
	tmux
	fzf

	#languages
	gcc
	clang
	nodejs_22
	go
	typescript
	stylua
	python312
  ];

  # started in user sessions.
   programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  hardware.opengl.enable = true;

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
