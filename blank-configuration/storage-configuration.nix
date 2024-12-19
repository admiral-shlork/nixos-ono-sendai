{ config, pkgs, modulesPath, ... }:

{
  boot = {
    initrd.availableKernelModules = [ "ahci" "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
    #initrd.kernelModules = [ "dm-snapshot" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-amd" ];
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = let
      luks_root_uuid = "2ba35a36-1b61-41c2-b603-dbe250f9c3fa";
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
  '';

  # SWAP partition - c30a3550-ab3b-4820-afc7-b833f4f3b36c
  # swapDevices =
  #   [ { device = "/dev/disk/by-uuid/c30a3550-ab3b-4820-afc7-b833f4f3b36c"; }
  #   ];

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
    { device = "/dev/disk/by-uuid/400978a0-5204-4b72-a9a4-ee90e03749c2";
      fsType = "ext4";
    };

  fileSystems."/home/whatever/mnt/beta" =
    { device = "/dev/disk/by-uuid/dc243f80-316b-496b-b8c6-62881134059d";
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

  fileSystems."/home/whatever/mnt/win10" =
    { device = "/dev/disk/by-label/win10";
      fsType = "ntfs";
    };

  fileSystems."/home/whatever/mnt/win11" =
    { device = "/dev/disk/by-label/win11";
      fsType = "ntfs";
    };
}
