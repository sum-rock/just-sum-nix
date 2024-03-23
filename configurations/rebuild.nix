{ config, lib, pkgs, ... }:
let
  rebuild = pkgs.writeScriptBin "rebuild" ''
    ${builtins.readFile ./rebuild.sh}
  '';
in
{
  environment.systemPackages = [ rebuild ];
}
