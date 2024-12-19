{ config, pkgs, lib, modulesPath, ... }:

{
  networking.hostName = "ono-sendai";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
}
