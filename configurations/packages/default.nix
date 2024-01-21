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
    nix-index
    poetry
    postgresql
    tree-sitter
    nodejs
    yarn

    # Applications
    # ------------
    dbeaver
    element-desktop

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
