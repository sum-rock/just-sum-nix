{ config, lib, pkgs, ... }:
let
  script =
    if config.system == "aarch64-darwin"
    then builtins.readFile ./rebuild-darwin.sh
    else builtins.readFile ./rebuild-nixos.sh;
  rebuild = pkgs.writeScriptBin "rebuild" ''
    ${script}
  '';
in
{
  environment.systemPackages = [ rebuild ];
}

