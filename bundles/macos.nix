{ config, pkgs, ... }:
{
  imports = [ 
    ./packages/common.nix 
    ./packages/workstation.nix
  ];

  # This font dir option is specific to darwin.
  fonts.fontDir.enable = true;

 # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true; 

  nix.package = pkgs.nix;
}

