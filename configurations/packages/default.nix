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
    go
    gcc
    nix-index
    poetry
    postgresql
    tree-sitter
    nodejs
    yarn
    sqlite

    # Applications
    # ------------
    dbeaver

    # Quality of Life
    # ---------------
    eza
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
    shell_gpt
  ];

}
