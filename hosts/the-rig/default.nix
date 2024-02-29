{ config, pkgs, private, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common/nvidia-standard.nix
      private.nixosModules.syncthing
      private.nixosModules.secrets
    ];

  networking.hostName = "the-rig"; # Define your hostname.

  # services.openiscsi = {
  #   enable = true;
  #   enableAutoLoginOut = true;
  #   discoverPortal = "100.115.195.75";
  #   name = "iqn.2003-01.org.linux-iscsi.silo.x8664:sn.4cce07f0ab02";
  # };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
    "/keyfile-a" = null;
    "/keyfile-b" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-ace462e3-0654-4cf6-a577-3d1c850dca6d".device = "/dev/disk/by-uuid/ace462e3-0654-4cf6-a577-3d1c850dca6d";
  boot.initrd.luks.devices."luks-ace462e3-0654-4cf6-a577-3d1c850dca6d".keyFile = "/crypto_keyfile.bin";

  # Additional Encrypted Drives
  # =======================================================
  # add keyfiles to drives with the following:
  #   $ sudo cryptsetup luksAddKey /dev/sdx /crypto_keyfile.bin

  boot.initrd.luks.devices."vol1" = {
    device = "/dev/disk/by-uuid/2c550cef-9396-4f65-9d96-cf352b2464e7";
    keyFile = "/keyfile-a";
  }; 
  boot.initrd.luks.devices."vol2" = {
    device = "/dev/disk/by-uuid/1528737e-f734-4f7f-8652-c2d767e2095d";
    keyFile = "/keyfile-b";
  }; 

  # Note: the mounting directory must exist and it must be within home
  # Note: using config.primary-user here made the rebuild timeout
  fileSystems."/home/august/Nextcloud" = { 
    device = "/dev/mapper/vol1";
    fsType = "ext4";
  };
  fileSystems."/home/august/Games" = { 
    device = "/dev/mapper/vol2";
    fsType = "xfs";
  };

}
