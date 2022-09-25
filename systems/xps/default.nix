{ config, lib, nixpkgs, home-manager, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      home-manager.nixosModule
      ./hardware-configuration.nix
      ../../bundles/workstation
      ../../desktops/sway
    ];

  # Boot drive stuff
  # ----------------
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    version = 2; 
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/903f7f9b-523f-4196-978b-7a8b8ea73c71";
      preLVM = true;
    };
  };

  networking.hostName = "xps"; 
  
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  
  # Nvidia drivers
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # Enable screen brightness control
  programs.light.enable = true;
  users.groups.video.members = [ "august" ]; 

}
