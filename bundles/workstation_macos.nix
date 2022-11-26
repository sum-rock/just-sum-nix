{ config, pkgs, ... }:
{

  imports = [ ./common.nix ];

  # This font dir option is specific to darwin.
  fonts.fontDir.enable = true;

  nixpkgs.config.allowBroken = true;

  # System
  # ------
  services.nix-daemon.enable = true;  # Auto upgrade nix package and the daemon service.
  services.postgresql.enable = false;

  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;

  # Packages
  # --------
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    chromedriver
    postgresql_14
    sqlite
    duplicity
    tree-sitter
    dbeaver
  ];
}

