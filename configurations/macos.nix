{ config, pkgs, nixpkgs-unstable, ... }:
let 
  unstable = import nixpkgs-unstable {
    system = "aarch64-darwin";
    config = {};
  }; 
in
{
  imports = [
    ./packages.nix
    ./rebuild
  ];

  nixpkgs.config = { allowUnfree = true; allowBroken = true; };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = 5;
  system.primaryUser = config.primaryUser;

  # Enable both fish and zsh because that's how nix is added to the path
  programs.fish.enable = true;
  programs.zsh.enable = true;

  environment.shells = [pkgs.fish];
  environment.systemPackages = [
    unstable.nodejs_24
  ];

  users.users.${config.primaryUser} = {
    home = "${config.home-dir-path}";
    shell = pkgs.fish;
  };
  # nix.package = pkgs.nix;
}
