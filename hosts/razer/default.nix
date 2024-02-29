{ config, pkgs, private, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../common/nvidia-standard.nix
      private.nixosModules.syncthing
      private.nixosModules.secrets
    ];

  # Boot Loader stuff
  # -----------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-f7239e4c-7fd0-4b9a-a322-5f8d7fa3e219".device = "/dev/disk/by-uuid/f7239e4c-7fd0-4b9a-a322-5f8d7fa3e219";
  boot.initrd.luks.devices."luks-f7239e4c-7fd0-4b9a-a322-5f8d7fa3e219".keyFile = "/crypto_keyfile.bin";

  # Hostname
  networking.hostName = "razer";

  hardware.openrazer.enable = true;
  environment.systemPackages = with pkgs; [ 
    razergenie 
    openrazer-daemon
  ];

  hardware.bluetooth.enable = true;
}
