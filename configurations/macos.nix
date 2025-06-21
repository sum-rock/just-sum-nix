{ config, pkgs, ... }:
{
  imports = [
    ./packages.nix
    ./rebuild
  ];

  nixpkgs.config = { allowUnfree = true; allowBroken = true; };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = 5;

  # Enable both fish and zsh because that's how nix is added to the path
  programs.fish.enable = true;
  programs.zsh.enable = true;

  nix.package = pkgs.nix;
}
