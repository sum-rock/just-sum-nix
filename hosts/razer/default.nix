{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  hardware.bluetooth.enable = true;

  # NVIDIA Drivers
  # --------------
  services.xserver = {
    libinput.enable = true;
    videoDrivers = [ "nvidia" ];
  };
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    opengl = {
      enable = true;
      extraPackages = [
        pkgs.mesa.drivers
        pkgs.linuxPackages.nvidia_x11.out
      ];
    };
  };
}
