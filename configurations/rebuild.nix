{ config, lib, pkgs, ... }:
let
  rebuild = pkgs.writeScriptBin "rebuild" ''
    ${builtins.readFile ./backups.sh}
  '';
in
{
  environment.systemPackages = [ rebuild ];
}
