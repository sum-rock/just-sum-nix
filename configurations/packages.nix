{
  pkgs,
  nixpkgs-logseq,
  ...
}:
let
  logseq-pkgs = import nixpkgs-logseq {
    system = pkgs.stdenv.hostPlatform.system;
  };
in
{
  environment.systemPackages = with pkgs; [

    # Logseq 2.x uses database graphs on both NixOS and macOS.
    logseq-pkgs.logseq_2

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
    github-cli
    codex

    # Quality of Life
    # ---------------
    eza
    ripgrep
    tmux
    btop
    dust
    lazydocker
    lazygit
    jq
    hyfetch
    glow
    libqalculate
    skopeo # for getting the nix-hash of a docker image

    # MCP
    github-mcp-server
  ];

}
