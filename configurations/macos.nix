{ config, pkgs, ... }:
{
  imports = [
    ./packages.nix
    ./rebuild
  ];

  # This font dir option is specific to darwin.
  fonts.fontDir.enable = true;

  nixpkgs.config = { allowUnfree = true; allowBroken = true; };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.fish.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.package = pkgs.nix;
}

