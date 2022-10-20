{ config, lib, pkgs, home-manager, ... }:
{

  imports = 
  [
    home-manager.darwinModule
    ./components/alacritty.nix
    ./components/neovim
  ];

  # This font dir option is specific to darwin.
  fonts.fontDir.enable = true;

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
    python310
    neofetch
    tmux
    btop
    ranger
    gitui
    exa         # Better than ls
    ripgrep
    wget
    git
  ];
}
