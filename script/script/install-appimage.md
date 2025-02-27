## first you need to install appimage in your system

  environment.systemPackages = with pkgs; [
    appimage-run 
  ];
  programs.appimage.enable = true;
  programs.appimage.binfmt = true; # Registers AppImages to run directly

mkdir -p ~/.local/share/applications
nano ~/.local/share/applications/zen.desktop
    add this: 
        [Desktop Entry]
        Name=Zen Browser
        Exec=/home/dinesh/bin/zen
        Type=Application
        Terminal=false
        Comment=Launch Zen Browser
        Icon=/home/dinesh/path/to/icon.png  # Optional: add an icon path if you have one
update if it doesnot work
      *update-desktop-database ~/.local/share/applications

## now you can search usign zen brower in you app using i3
