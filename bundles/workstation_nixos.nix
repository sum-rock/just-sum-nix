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

  # Audio
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
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

    # Yubikey
    # -------
    yubico-piv-tool
    yubikey-personalization
    pinentry-curses
    paperkey

    # Gaming
    # ------
    qbittorrent
    discord
    renpy
    wine-staging
    winetricks

    # Applications 
    # ------------
    standardnotes
    dbeaver

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
  programs.ssh.startAgent = false;
  services.udev.packages = [ pkgs.yubikey-personalization ];
  services.pcscd.enable = true;
  environment.shellInit = ''
    export GPG_TTY="$(tty)"
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK="/run/user/1000/gnupg/S.gpg-agent.ssh"
  '';
}
