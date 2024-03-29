{ config, pkgs, ... }:
{
  imports = [ ./packages.nix ];

  # This font dir option is specific to darwin.
  fonts.fontDir.enable = true;

  nixpkgs.config = { allowUnfree = true; allowBroken = true; };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

 # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true; 

  nix.package = pkgs.nix;
}

