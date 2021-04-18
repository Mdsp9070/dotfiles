{ config, lib, pkgs, ... }:

{

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "vt.default_red=0x4c,0xff,0xa3,0xdb,0x5c,0xb9,0x27,0xff,0x63,0xf9,0x4f,0xdb,0x69,0xb9,0x70,0xff" 
    "vt.default_grn=0x4c,0x6c,0xdf,0xee,0xb6,0x81,0xc3,0xff,0x83,0x54,0xda,0xee,0xc3,0x81,0x97,0xff" 
    "vt.default_blu=0x4c,0x6c,0x4c,0x77,0x4f,0xf4,0xff,0xff,0xa7,0x6d,0xee,0x77,0x5c,0xf4,0xff,0xff"
  ];

  boot.extraModprobeConfig = ''
  options ath9wk btcoex_enable=1 bt_ant_diversity=1
  options snd_hda_intel index=1
  '';

  boot.blacklistedKernelModules = [ "acer_wmi" ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.grub.splashImage = "/etc/nixos/system/boot_wallpaper.jpg"; 
  boot.loader.grub.useOSProber = true;
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  }; 

  services.fstrim = {
    enable = true;
    interval = "weekly";
  };

  hardware.cpu.intel.updateMicrocode = true;

  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  hardware.bluetooth = {
    enable = true;
    config = {

      General = {
        Name = "mdsp-note";
        DiscoverableTimeout = 0;
        AlwaysPairable = true;
        FastConnectable = true;
      };

      Policy = {
        AutoEnable = true;
        ReconnectAttempts = 5;
        ReconnectIntervals = "1,2,4,8,16";
      };

    };
  };

  boot.cleanTmpDir = true;
}
