{ config, lib, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ../common/nvidia-offload.nix
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
  
  # Enable screen brightness control
  # --------------------------------
  # NOTE: Must add operating user to the "video" group in a profile.
  # NOTE: To find the correct keybindings run the command below and subtract 8 
  # from the resulting keycode
  #   nix-shell -p xorg.xev --run "xev -event keyboard"
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 5"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 5"; }
    ];
  };

  hardware.bluetooth.enable = true;

  # Increase DPI because of 4K
  services.xserver.dpi = 180;
}
