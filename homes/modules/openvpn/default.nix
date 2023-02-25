{ config, pkgs, ... }:
let 
  vpn-connect = pkgs.writeShellScriptBin "vpn-connect" ''
    ${builtins.readFile ./vpn-connect.sh}
  '';
in
{
  environment.systemPackages = [ vpn-connect ];
}
