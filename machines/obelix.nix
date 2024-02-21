{ config, lib, pkgs, modulesPath, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };

  # windows handles time in dual boot
  time.hardwareClockInLocalTime = true;

  networking.hostName = "obelix";

  boot = {
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
    };

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
    cleanTmpDir = true;

    loader = {
      systemd-boot = {
        enable = true;
        # /boot/efi is a small partition
        configurationLimit = 5;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
  };

  # TODO switch to labels
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/8dbc61d8-140d-4119-90a8-c95a901b53c6";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-uuid/76EE-E5BC";
      fsType = "vfat";
    };
  };

  #fileSystems = {
  #"/" = {
  #device = "/dev/disk/by-label/root";
  #fsType = "ext4";
  #};

  #"/boot" = {
  #device = "/dev/disk/by-label/boot";
  #fsType = "vfat";
  #};
  #};

  #swapDevices = [{ device = "/dev/disk/by-label/swap"; }];
  # TODO add swap
  swapDevices = [ ];

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    cpu.amd.updateMicrocode = config.hardware.enableRedistributableFirmware;

    # TODO enable custom fan control
    #fancontrol = {
    #enable = true;
    #config = "";
    #};
  };

  # TODO
  #powerManagement.cpuFreqGovernor = lib.mkDefault "conservative";
}
