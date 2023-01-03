{ config, pkgs, ... }:
{
  options = {
    primary-user = pkgs.lib.mkOption {
      description = "Username for the primary user.";
    };
    home-dir-path = pkgs.lib.mkOption {
      description = "Home directory path for the primary user.";
    };
  };
  config.environment.systemPackages = with pkgs; [

    # Basics
    # ------
    zsh
    wget
    curl
    git
    unzip
    htop
    gnugrep
    gnupg
    openssl
    age

    # Quality of Life
    # ---------------
    exa
    ripgrep
    tmux
    btop
    du-dust
    lazydocker
    lazygit
    jq
    neofetch
    glow
    duplicity
  ];
}
