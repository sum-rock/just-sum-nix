{ config, pkgs, ... }:
{
  config.environment.systemPackages = with pkgs; [

    # Basics
    # ------
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
    gnumake

    # Programming
    # -----------
    go
    gcc
    nix-index
    poetry
    postgresql
    tree-sitter
    nodejs
    yarn
    sqlite
    ngrok

    # Applications
    # ------------
    dbeaver
    obs-studio

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
    shell_gpt
  ];

}
