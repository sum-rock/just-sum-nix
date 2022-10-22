# Configs common to all workstation installations of Nixos

{ config, pkgs, home-manager, ... }:

{
  
  # System
  # ===========================================================================
  # Must declare state here and it must match the release channel in flake.nix
  system.stateVersion = "22.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Localization
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true; 
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Home manager settings
  #   These allow a rebuild without raising the "impure" warning. See issue 
  #   here https://github.com/divnix/digga/issues/30
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  
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
    vi              # Good for backup 
    neovim
    wget
    git
    zsh
    networkmanager
    psmisc          # Includes ps commands that are commonly used. (e.g., killall)
    python310
    neofetch
    tmux
    btop
    ranger
    gitui
    pciutils
    vlc
    ffmpeg
    exa             # Better than ls
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

}
