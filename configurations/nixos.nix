{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./packages/common.nix 
    ./packages/workstation.nix
  ];
  
  # System
  # ===========================================================================
  system.stateVersion = "${config.nixos-version}";

  # Localization
  time.timeZone = "${config.timezone}";
  i18n.defaultLocale = "${config.localization}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${config.localization}";
    LC_IDENTIFICATION = "${config.localization}";
    LC_MEASUREMENT = "${config.localization}";
    LC_MONETARY = "${config.localization}";
    LC_NAME = "${config.localization}";
    LC_NUMERIC = "${config.localization}";
    LC_PAPER = "${config.localization}";
    LC_TELEPHONE = "${config.localization}";
    LC_TIME = "${config.localization}";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
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
      chromium
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
    openvpn         #   Configs for nordvpn in home
    sops

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
    standardnotes     # This could be in workstation but does not evalulate on M1
    spotify           # This could also be in workstation if it worked on M1
    _1password-gui
    nextcloud-client

    # Other
    # -----
    woeusb            # To make Windows USBs
    ntfs3g
    veracrypt
    input-remapper
    exiftool
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
