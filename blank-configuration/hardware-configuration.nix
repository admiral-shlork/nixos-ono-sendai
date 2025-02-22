{ config, lib, pkgs, modulesPath, ... }:

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  services.xserver.videoDrivers = ["nvidia"]; 
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Lenovo 5D50X AKA ThinkPad Trackpoint II USB/Bluetooth Keyboard.
  services.udev.extraRules = ''
    ## Handle Fn Lock light for ThinkPad Trackpoint II USB/Bluetooth Keyboard
    SUBSYSTEM=="hid", DRIVER=="lenovo", ATTRS{idVendor}=="17ef", ATTRS{idProduct}=="6047|60ee", ATTR{fn_lock}="0"
    SUBSYSTEM=="input", ATTRS{id/vendor}=="17ef", ATTRS{id/product}=="6048|60e1", TEST=="/sys/$devpath/device/fn_lock", RUN+="/bin/sh -c 'echo 0 > \"/sys/$devpath/device/fn_lock\"'"
  '';

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
