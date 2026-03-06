{ config, pkgs, nixpkgs-unstable, ... }:
let
  system = 
    if config.system ? darwinVersion
    then "aarch64-darwin"
    else "x86_64-linux";

  unstable = import nixpkgs-unstable {
    system = system; 
    config = {};
  }; 
in
{
  imports = [ ./mk-options.nix ];

  # Set as applicable to you- the person using this flake
  primaryUser = "august";
  timezone = "America/Chicago";
  localization = "en_US.UTF-8";

  sumAstroNvim = {
    username = "august";
    nerdfont = pkgs.nerd-fonts.lilex;
    nodePackage = unstable.nodejs_24;
    pythonPackage = pkgs.python314;
  };

}
