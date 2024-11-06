{ config, pkgs, nixpkgs-unstable, ... }:
let
  unstable = import nixpkgs-unstable {
    system = "aarch64-darwin";
    config = { };
  };
in
{
  imports = [
    ./packages.nix
    ./rebuild
  ];

  nixpkgs.config = { allowUnfree = true; allowBroken = true; };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = 4;

  # Enable both fish and zsh because that's how nix is added to the path
  programs.fish.enable = true;
  programs.zsh.enable = true;

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  environment.systemPackages = [
   unstable.neovim-unwrapped
  ];

}

