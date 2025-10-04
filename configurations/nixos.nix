{ config, lib, pkgs, nixpkgs-unstable, ... }:
let
  unstable = import nixpkgs-unstable {
    system = "aarch64-darwin";
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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config = {
    allowUnfree = true;
    # This is specifically for Logseq
    permittedInsecurePackages = [ "electron-27.3.11" ];
  };

  # Localization
  time.timeZone = "${config.timezone}";
  i18n.defaultLocale = "${config.localization}";

  # keyboard
  hardware.keyboard.qmk.enable = true;

  # Android Debug Bridge
  programs.adb.enable = true;

  services.udev.packages = [ pkgs.via pkgs.android-udev-rules ];

  # Audio
  services.pulseaudio.enable = false;
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
  users.users.${config.primaryUser} = {
    isNormalUser = true;
    description = "${config.primaryUser}";
    extraGroups = [ "wheel" "video" "networkmanager" "plugdev" "docker" "adbusers" ];
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
    via

    # pipewire controls
    # -------------
    pulseaudio
    pamixer
    pavucontrol

    # Gaming
    # ------
    steamcmd
    steamtinkerlaunch
    renpy
    wine
    winetricks
    protontricks
    p7zip

    # ebooks
    # ------
    calibre
    koreader

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
    opencode # can install on nixos but not in darwin

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
    exiftool
    android-tools

    (appimage-run.override {
      extraPkgs =
        pkgs: with pkgs; [
          libthai
          libsecret
        ];
    })
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # package = unstable.neovim-unwrapped;
  };

  services.tailscale.enable = true;
  virtualisation.docker.enable = true;
}
