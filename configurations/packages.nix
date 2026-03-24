{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

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
    yarn
    sqlite
    ngrok
    bind
    bruno

    # Quality of Life
    # ---------------
    eza
    ripgrep
    tmux
    btop
    dust
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
