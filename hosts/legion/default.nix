{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../common/nvidia-standard.nix
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "legion";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  system.stateVersion = "24.05"; # Did you read the comment?

  environment.systemPackages = with pkgs; [
    lenovo-legion
  ];
}
