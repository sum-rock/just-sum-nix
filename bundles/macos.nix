{ config, lib, pkgs, ... }:
{

  imports = 
  [
    ./components/alacritty
    ./components/neovim
  ];
  
  # System
  # ------
  # Must declare state here and it must match the release channel in flake.nix
  # system.stateVersion = "22.05";
  services.nix-daemon.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Programs
  # --------
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    python310
    neofetch
    tmux
    btop
    ranger
    gitui
    exa           # Better than ls
    ripgrep
    wget
    git
  ];
}
