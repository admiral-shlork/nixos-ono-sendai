{ config, pkgs, modulesPath, ... }:

{
boot = {
  # Bootloader
  initrd.availableKernelModules = [ "ahci" "ata_piix" "ohci_pci" "ehci_pci" "xhci_pci" "nvme" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  initrd.kernelModules = [ "dm-snapshot" ];
  kernelModules = [ "kvm-intel" "iwlwifi" ];
  kernelPackages = pkgs.linuxPackages_latest;
  extraModulePackages = [ ];
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  initrd.luks.devices = let
    luks_root_uuid = "1b6910b0-cbce-4a7d-8231-f9579acce464";
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

  # SWAP partition - f75e9a16-fe77-4f53-aedb-ba1ecfedd097
  swapDevices =
    [ { device = "/dev/disk/by-uuid/f75e9a16-fe77-4f53-aedb-ba1ecfedd097"; }
    ];

  # / partition - 2a1300b3-fa2c-4aff-8657-88aab66c1477
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/2a1300b3-fa2c-4aff-8657-88aab66c1477";
      fsType = "ext4";
    };

  # /boot partition - F4E7-DE8F
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/F4E7-DE8F";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  # /home partition - 2227f51d-958b-49a4-b048-26112e1fb51c
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/2227f51d-958b-49a4-b048-26112e1fb51c";
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
