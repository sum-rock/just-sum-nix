{ config, lib, pkgs, ... }:
{

  imports = 
  [
    <home-manager/nix-darwin>
    ./components/alacritty.nix
    # ./components/neovim
  ];

  # This font dir option is specific to darwin.
  fonts.fontDir.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = 4;

  programs.zsh.enable = true;

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
