{ config, pkgs, modulesPath, ... }:

{
  boot = {
    initrd.availableKernelModules = [ "ahci" "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    #initrd.kernelModules = [ "dm-snapshot" ];
    initrd.kernelModules = [ ];
    # kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_6_12; #kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "kvm.enable_virt_at_load=0" ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = let
      luks_root_uuid = "a6f03b03-af9e-479f-b7b5-fa4b37b4ce4b";
    in {
      # LUKS container with root partition
      "luks-${luks_root_uuid}" = {
        device = "/dev/disk/by-uuid/${luks_root_uuid}";
        allowDiscards = true;
      };
    };
  };

  # Configuration for LUKS containers and key files
  environment.etc.crypttab.text = ''
    cryptalpha UUID=1fa0b0d6-231b-484f-975e-bb20f0b6febd /root/alpha.key
    cryptbeta UUID=122683dc-1b5b-45e6-9a6f-85def4e4d3c0 /root/beta.key
    cryptgamma UUID=b808597c-7261-4784-9d0c-89c213ca317f /root/gamma.key
    cryptdelta UUID=13a9a6e1-b23f-4a37-900b-f7b6fa9ba253 /root/delta.key
  '';

  # swapDevices = [{ 
  #     device = "/dev/disk/by-uuid/c30a3550-ab3b-4820-afc7-b833f4f3b36c";
      # device = "/swapfile";
      # size = 64 * 1024;
  #   }];

  fileSystems."/" =
    { device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };

  fileSystems."/home/whatever/mnt/alpha" =
    { device = "/dev/disk/by-label/alpha";
      fsType = "ext4";
    };

  fileSystems."/home/whatever/mnt/beta" =
    { device = "/dev/disk/by-label/beta";
      fsType = "ext4";
    };

  fileSystems."/home/whatever/mnt/gamma" =
    { device = "/dev/disk/by-label/gamma";
      fsType = "ext4";
    };

  fileSystems."/home/whatever/mnt/delta" =
    { device = "/dev/disk/by-label/delta";
      fsType = "ext4";
    };

  fileSystems."/home/whatever/mnt/ssd_001" =
    { device = "/dev/disk/by-label/ssd_001";
      fsType = "ntfs";
    };

  fileSystems."/home/whatever/mnt/ssd_002" =
    { device = "/dev/disk/by-label/ssd_002";
      fsType = "ntfs";
    };

  # fileSystems."/home/whatever/mnt/ssd_003" =
  #   { device = "/dev/disk/by-label/ssd_003";
  #     fsType = "ntfs";
  #   };

  fileSystems."/home/whatever/mnt/win11" =
    { device = "/dev/disk/by-label/win11";
      fsType = "ntfs";
    };
}
