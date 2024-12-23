{ lib, pkgs, ... }:
{
  # CAUTION: Driver Needed
  # - Determine the current version on the driver allowed in nixpkgs by searching the nix
  #   repository. As of writing this is version 5.8.
  # - Download the correct version of the driver from the displaylink website.
  # - Execute:
  #     mv $PWD/DisplayLink\ USB\ Graphics\ Software\ for\ $PWD/Ubuntu5.8-EXE.zip displaylink-580.zip
  #     nix-prefetch-url --name displaylink-580.zip file://$PWD/displaylink-580.zip

  # https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/nvidia/default.nix
  #   Just a lazy extension of the nixos-hardware module to include the displaylink driver
  services.xserver.videoDrivers = [ "displaylink" "modesetting" "nvidia" ];


  services.xserver.displayManager.sessionCommands = ''
    ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
  '';
}
