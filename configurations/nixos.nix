{ config, lib, pkgs, nixpkgs-unstable, ... }:
let
  unstable = import nixpkgs-unstable {
    system = "x86_64-linux";
    config = { };
  };
in
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
    permittedInsecurePackages = [ "electron-27.3.11" ];
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
    extraGroups = [ "wheel" "video" "networkmanager" "plugdev" "docker" ]; # "openrazer"
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
      chromium
    ];
  };

  # Internet stuff
  # ===========================================================================
  networking.firewall = {
    enable = true;
    # For immersed
    allowedTCPPorts = [ 21000 21013 ];
    allowedUDPPorts = [ 21000 21010 ];
  };

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
    # qbittorrent
    renpy
    wine
    winetricks
    protontricks
    p7zip

    # Applications 
    # ------------
    _1password-gui
    nextcloud-client
    logseq
    inkscape
    gimp
    copyq
    sidequest
    spotify
    mongodb-compass
    obs-studio
    dbeaver-bin

    # messaging
    # ---------
    zoom-us
    element-desktop
    whatsapp-for-linux
    discord

    # Other
    # -----
    woeusb # To make Windows USBs
    ntfs3g
    veracrypt
    input-remapper
    exiftool
    android-tools
    android-udev-rules

    (appimage-run.override {
      extraPkgs =
        pkgs: with pkgs; [
          libthai
          libsecret
        ];
    })
  ];

  # Default Editor
  programs.neovim = {
    enable = true;
    package = unstable.neovim-unwrapped;
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
