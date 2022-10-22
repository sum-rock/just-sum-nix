# Configs common to all workstation installations of Nixos

{ config, pkgs, ... }:

{
  imports = 
  [
    ./components/minimal.nix
    ./components/i3wm.nix
    ./components/alacritty.nix
    ./components/neovim
  ];
  
  # User setup
  # ----------
  users.users.august = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };

  # Programs
  # --------
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    python310
    neofetch
    tmux
    btop
    ranger
    gitui
    pciutils
    vlc
    ffmpeg
    exa           # Better than ls
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Localization
  # ------------
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Audio
  # -----
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true; 
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
