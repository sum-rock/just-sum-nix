{ config, pkgs, ... }:
{
  imports =
    [ 
      ./hardware-configuration.nix
      ./system
      ./home
    ];
}
