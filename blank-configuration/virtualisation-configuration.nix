{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
      enableNvidia = true;
    };
  };
  users.groups.libvirtd.members = ["root" "whatever" ];
}
