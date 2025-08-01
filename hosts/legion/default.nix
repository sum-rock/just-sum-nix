{ config, lib, pkgs, nixos-hardware, nix-impermanence, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./persistance.nix
      ./displaylink.nix
      ./subvol_delete
      nixos-hardware.nixosModules.lenovo-legion-16irx9h
      nix-impermanence.nixosModules.impermanence
    ];


  # This solves issues related to waking from sleep.
  hardware.nvidia.powerManagement.enable = false;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "legion";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  system.stateVersion = "24.05"; # Did you read the comment?

  environment.systemPackages = with pkgs; [
    lenovo-legion
    input-remapper
  ];

  users.users.${config.primaryUser} = {
    hashedPassword = "$y$j9T$zIhzVDjq/JpRoqrmwCSG4/$xoRiXmuuhAKIls/QpjbWRAqPiG48BuSE.HhpacwWSq/";
  };
}
