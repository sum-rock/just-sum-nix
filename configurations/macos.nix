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

  # Enable both fish and zsh because that's how nix is added to the path
  programs.fish.enable = true;
  programs.zsh.enable = true;

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}

