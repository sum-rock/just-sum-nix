{ config, pkgs, ... }:
{
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
    borgbackup

    # Programming
    # -----------
    python311
    nix-index
    poetry
    postgresql_16
    tree-sitter
    nodejs
    yarn

    # Applications
    # ------------
    dbeaver
    element-desktop

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
    libqalculate
    cachix
  ];

}
