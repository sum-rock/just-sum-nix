{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    # Programing tools
    # ----------------
    python39Full
    python39Packages.isort
    python39Packages.black
    python310
    python310Packages.black
    python310Packages.isort
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
    
  ];
}
