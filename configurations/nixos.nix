{ config, lib, pkgs, ... }:
{
  imports = [
    ./packages.nix
    ./rebuild
  ];

  # System
  # ===========================================================================
  system.stateVersion = "${config.nixos-version}";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config = {
    allowUnfree = true;
    # This is specifically for Logseq
    permittedInsecurePackages = [ "electron-25.9.0" "nix-2.15.3" ];
  };

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
  services.avahi.openFirewall = true; # wifi printing
  services.printing.drivers = with pkgs; [
    gutenprint
    cups-brother-hl3140cw
  ];

  # User setup
  # ===========================================================================
  users.users.${config.primary-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "plugdev" "openrazer" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
      chromium
    ];
  };

  # Internet stuff
  # ===========================================================================
  networking.firewall.enable = true;
  # Required for tailscale exit node use
  networking.firewall.checkReversePath = "loose";
  networking.networkmanager.enable = true;
  services.openssh.enable = true;

  # System Programs
  # ===========================================================================
  programs.fish.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  environment.systemPackages = with pkgs; [

    # Basics
    # ------
    pulseaudio # | 
    pamixer # | For pipewire controls
    pavucontrol # |
    networkmanager
    psmisc # Includes ps commands that are commonly used. (e.g., killall)
    pciutils
    vlc
    ffmpeg_6-full
    cmake
    sops
    docker-compose
    nfs-utils
    wl-clipboard

    # Yubikey
    # -------
    yubico-piv-tool
    yubikey-personalization
    pinentry-curses
    paperkey

    # Gaming
    # ------
    steamcmd
    steamtinkerlaunch
    qbittorrent
    renpy
    wine
    winetricks
    protontricks
    p7zip

    # Applications 
    # ------------
    discord
    _1password-gui
    nextcloud-client
    zoom-us
    skypeforlinux
    element-desktop
    logseq
    inkscape
    gimp
    copyq
    sidequest
    immersed-vr

    # Applications not on M1
    # ----------------------
    spotify
    mongodb-compass

    # Other
    # -----
    woeusb # To make Windows USBs
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

  services.tailscale.enable = true;
  virtualisation.docker.enable = true;
}
