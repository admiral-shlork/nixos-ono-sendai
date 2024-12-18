{ config, pkgs, modulesPath, ... }:

{
boot = {
  # Bootloader
  initrd.availableKernelModules = [ "ahci" "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  initrd.kernelModules = [ "dm-snapshot" ];
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
  # LUKS container with alpha partition - 1fa0b0d6-231b-484f-975e-bb20f0b6febd
  # LUKS container with beta partition - 122683dc-1b5b-45e6-9a6f-85def4e4d3c0  
  environment.etc.crypttab.text = ''
    cryptalpha UUID=1fa0b0d6-231b-484f-975e-bb20f0b6febd /root/alpha.key
    cryptbeta UUID=122683dc-1b5b-45e6-9a6f-85def4e4d3c0 /root/beta.key
  '';

  # SWAP partition - c30a3550-ab3b-4820-afc7-b833f4f3b36c
  swapDevices =
    [ { device = "/dev/disk/by-uuid/c30a3550-ab3b-4820-afc7-b833f4f3b36c"; }
    ];

  # / partition - 7c1e4624-f7b5-4906-adc6-7a452e6820f7
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/7c1e4624-f7b5-4906-adc6-7a452e6820f7";
      fsType = "ext4";
    };

  # /boot partition - 9D31-F855
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9D31-F855";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  # /home partition - 390386ad-d3fc-47f4-b880-f3f62d8e69e5
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/390386ad-d3fc-47f4-b880-f3f62d8e69e5";
      fsType = "ext4";
    };
  # ~/mnt/alpha partition - 400978a0-5204-4b72-a9a4-ee90e03749c2
  fileSystems."/home/whatever/mnt/alpha" =
    { device = "/dev/disk/by-uuid/400978a0-5204-4b72-a9a4-ee90e03749c2";
      fsType = "ext4";
    };
  # ~/mnt/beta partition - dc243f80-316b-496b-b8c6-62881134059d
  fileSystems."/home/whatever/mnt/beta" =
    { device = "/dev/disk/by-uuid/dc243f80-316b-496b-b8c6-62881134059d";
      fsType = "ext4";
    };
  # ~/mnt/ssd_001 partition - BE4EEA784EEA28BB
  fileSystems."/home/whatever/mnt/ssd_001" =
    { device = "/dev/disk/by-uuid/BE4EEA784EEA28BB";
      fsType = "ntfs";
    };
  # ~/mnt/ssd_002 partition - BAA04AB0A04A7345
  fileSystems."/home/whatever/mnt/ssd_002" =
    { device = "/dev/disk/by-uuid/BAA04AB0A04A7345";
      fsType = "ntfs";
    };
  # ~/mnt/win10 partition - 32DC7B8FDC7B4C5B
  fileSystems."/home/whatever/mnt/win10" =
    { device = "/dev/disk/by-uuid/32DC7B8FDC7B4C5B";
      fsType = "ntfs";
    };
  # ~/mnt/win11 partition - BA7A5EC27A5E7AD9
  fileSystems."/home/whatever/mnt/win11" =
    { device = "/dev/disk/by-uuid/BA7A5EC27A5E7AD9";
      fsType = "ntfs";
    };
}
