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
    elmPackages.elm
    gcc
    nix-index
    poetry
    postgresql
    tree-sitter
    nodejs
    yarn
    sqlite
    ngrok
    bind

    # Quality of Life
    # ---------------
    eza
    ripgrep
    tmux
    btop
    du-dust
    lazydocker
    lazygit
    rainfrog
    jq
    neofetch
    glow
    libqalculate
    shell-gpt
    skopeo # for getting the nix-hash of a docker image
  ];

}
