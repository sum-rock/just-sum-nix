{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./packages/common.nix 
    ./packages/workstation.nix
  ];
  
  # System
  # ===========================================================================
  # Must declare state here and it must match the release channel in flake.nix
  system.stateVersion = "unstable";

  # Localization
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Audio
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true; 
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing 
  # ===========================================================================
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.openFirewall = true;     # wifi printing
  services.ipp-usb.enable = true;         # USB printing 
  services.printing.drivers = with pkgs; [ 
    gutenprint 
    cups-brother-hl3140cw
  ];

  # User setup
  # ===========================================================================
  users.users.${config.primary-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "plugdev" "openrazer" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };
  
  # Internet stuff
  # ===========================================================================
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # System Programs
  # ===========================================================================
  programs.mtr.enable = true;
  programs.gnupg.agent = {
   enable = true;
   enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [

    # Basics
    # ------
    pulseaudio      # | 
    pamixer         # | For pipewire controls
    pavucontrol     # |
    networkmanager
    psmisc          #   Includes ps commands that are commonly used. (e.g., killall)
    pciutils
    vlc
    ffmpeg
    cmake

    # Yubikey
    # -------
    yubico-piv-tool
    yubikey-personalization
    pinentry-curses
    paperkey

    # Gaming
    # ------
    qbittorrent
    renpy
    wine
    winetricks
    protontricks
    p7zip

    # Applications 
    # ------------
    discord
    standardnotes   # This could be in workstation but does not evalulate on M1
    spotify         # This could also be in workstation if it worked on M1
    _1password-gui

    # Other
    # -----
    woeusb          # To make Windows USBs
    ntfs3g
    veracrypt
  ];

  # Default Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  
  # Steam Stuff
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Yubikey
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
}
