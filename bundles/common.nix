{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    # Programing tools
    # ----------------
    python39Full
    python39Packages.isort
    python39Packages.black
    poetry
    nodejs
    yarn
    pre-commit

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
    gitui
    lazydocker
    jq
    neofetch
    glow
    duplicity
  ];
}
