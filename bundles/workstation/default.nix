# Configs common to all workstation installations of Nixos
# Assumptions:
#   - GUI will be installed

{ config, pkgs, ... }:

{
  imports = 
  [
    ../components/common
    ../components/apps/alacritty
    ../components/apps/neovim
  ];
  
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

  # Add EXA aliases to zshrc
  home-manager.users.august = {
    programs.zsh.shellAliases = {
      lsx = "exa --long --all --header --group --git --icons --time-style=long-iso"; 
    };
  };

  # Add Firefox to user's package
  users.users.august = {
    packages = with pkgs; [
      firefox
    ];
  };

  # Localization
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Audio:
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true; 
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
