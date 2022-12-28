{ config, lib, pkgs, ... }:

{
  imports = [ ./common.nix ];
  
  # System
  # ===========================================================================
  # Must declare state here and it must match the release channel in flake.nix
  system.stateVersion = "unstable";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
  
  
  # Internet stuff
  # ===========================================================================
  networking.firewall.enable = true;
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # System Programs
  # ===========================================================================
  programs.mtr.enable = true;
  nixpkgs.config.allowUnfree = true;
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
    standardnotes
    spotify
    dbeaver
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
