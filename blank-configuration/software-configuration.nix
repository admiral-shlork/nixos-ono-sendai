{ config, pkgs, ... }:
{
  services.xserver.enable = true;

  # Enable the KDE Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  programs.firefox.enable = true;
  programs.direnv.enable = true;

  environment.systemPackages = with pkgs; [
    appimage-run
    brlaser
    git
    dconf-editor
    jellyfin-media-player
    ghostty
    home-manager
    nh
    terminator
    veracrypt
    vim
    virt-manager
    vscodium
    wget
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];

  # Set up libvirtd
  virtualisation.libvirtd = {
    enable = true;
  };
  users.groups.libvirtd.members = ["root" "whatever" ];
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "whatever" ];
  # virtualisation.virtualbox.guest.enable = true;
  
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
}
