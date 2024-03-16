{ config, lib, pkgs, ... }:
let
  rebuild = pkgs.writeScriptBin "rebuild" ''
    if [ "$EUID" -ne 0 ] ; then 
      echo "Must run rebuild as root!"
      exit
    fi

    MODE="boot"
    BRANCH="master"

    while getopts ":b:m:" o; do
      case "$o" in
        b)
          BRANCH=$OPTARG
          ;;
        m)
          MODE=$OPTARG
          ;;
        *)
          echo "Invalid option" 
          exit 1
          ;;
      esac
    done

    nixos-rebuild $MODE --option eval-cache false --flake ${config.githubAddress}/$BRANCH
  '';
in
{
  environment.systemPackages = [ rebuild ];
}
