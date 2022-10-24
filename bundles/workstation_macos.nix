{ config, pkgs, ... }:
{

  # This font dir option is specific to darwin.
  fonts.fontDir.enable = true;

  nixpkgs.config.allowBroken = true;

  # System
  # ------
  services.nix-daemon.enable = true;  # Auto upgrade nix package and the daemon service.
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
    nodejs
    yarn
    neofetch
    tmux
    btop
    gitui
    exa         # Better than ls
    ripgrep
    wget
    git
  ];
}

