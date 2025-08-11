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
    stateVersion = "25.05";
    packages = with pkgs; [
      alpaca
      audacity
      calibre
      code-cursor
      deadbeef
      deluge-gtk
      discord
      docker
      dropbox
      easytag
      element-desktop
      evince
      firefox-devedition
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
      obsidian
      parsec-bin
      protontricks
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
