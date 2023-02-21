{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common/nvidia-standard.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-ace462e3-0654-4cf6-a577-3d1c850dca6d".device = "/dev/disk/by-uuid/ace462e3-0654-4cf6-a577-3d1c850dca6d";
  boot.initrd.luks.devices."luks-ace462e3-0654-4cf6-a577-3d1c850dca6d".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "the-rig"; # Define your hostname.

}
