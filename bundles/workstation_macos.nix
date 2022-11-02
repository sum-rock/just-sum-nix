{ config, pkgs, ... }:
{

  # This font dir option is specific to darwin.
  fonts.fontDir.enable = true;

  nixpkgs.config.allowBroken = true;

  # System
  # ------
  services.nix-daemon.enable = true;  # Auto upgrade nix package and the daemon service.
  services.postgresql.enable = false;

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = 4;

  programs.zsh.enable = true;

  # Packages
  # --------
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    python39Full
    python39Packages.isort
    python39Packages.black
    chromedriver
    nodejs
    yarn
    neofetch
    tmux
    btop
    gitui
    exa         # Better than ls
    du-dust
    ripgrep
    gnugrep
    wget
    git
    jq
    gitui
    curl
    pre-commit
    postgresql_14
    sqlite
    glow
    lazydocker
    duplicity
    tree-sitter
    dbeaver
    openssl
    gnupg
  ];
}

