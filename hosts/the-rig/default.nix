{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common/nvidia-standard.nix
    ];

  networking.hostName = "the-rig"; # Define your hostname.

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

  # Additional Encrypted Drives
  # =======================================================
  # add keyfiles to drives with the following:
  #   $ sudo cryptsetup luksAddKey /dev/sdx /crypto_keyfile.bin

  boot.initrd.luks.devices."vol1" = {
    device = "/dev/disk/by-uuid/1528737e-f734-4f7f-8652-c2d767e2095d";
    keyFile = "/crypto_keyfile.bin";
  }; 

  # Note: the mounting directory must exist and it must be within home
  # Note: using config.primary-user here made the rebuild timeout
  fileSystems."/home/august/Games" = { 
    device = "/dev/mapper/vol1";
    fsType = "xfs";
  };

}
