{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./home-configuration/gnome-configuration.nix
      ./home-configuration/starship-configuration.nix
    ];

  # Home Manager configuration options go here
  home = {
    username = "whatever";
    homeDirectory = "/home/whatever";
    stateVersion = "24.11";
    packages = with pkgs; [
      audacity
      calibre
      deadbeef
      deluge-gtk
      discord
      docker
      dropbox
      easytag
      element-desktop
      evince
      firefox-devedition-bin
      floorp
      gimp
      gnome-screenshot
      jetbrains.pycharm-community
      keepassxc
      libreoffice
      librewolf
      lutris
      mangohud
      megasync
      nerdfonts
      obsidian
      parsec-bin
      protonvpn-gui
      python3
      python311Packages.pip
      signal-desktop
      soulseekqt
      soundconverter
      # steam
      telegram-desktop
      thunderbird
      ungoogled-chromium
      winbox
      wine
      # virtualbox
      vivaldi
      vlc
      yacreader
    ];
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      alias ll='ls -alhF'
      alias la='ls -A'
      alias l='ls -CF'
    '';
  };
}
