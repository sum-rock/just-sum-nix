{ pkgs, ... }:
let
  subvol_delete = pkgs.writeScriptBin "subvol-delete" ''
    ${builtins.readFile ./subvol_delete.sh}
  '';
in
{
  environment.systemPackages = [ subvol_delete ];
}
