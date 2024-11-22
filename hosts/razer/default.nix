{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common/nvidia-standard.nix
    ];

  # Boot Loader stuff
  # -----------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.kernelPackages = pkgs.linuxPackages;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-f7239e4c-7fd0-4b9a-a322-5f8d7fa3e219".device = "/dev/disk/by-uuid/f7239e4c-7fd0-4b9a-a322-5f8d7fa3e219";
  boot.initrd.luks.devices."luks-f7239e4c-7fd0-4b9a-a322-5f8d7fa3e219".keyFile = "/crypto_keyfile.bin";

  # Hostname
  networking.hostName = "razer";

  hardware.bluetooth.enable = true;
  system.stateVersion = "24.05"; # Did you read the comment?
}
