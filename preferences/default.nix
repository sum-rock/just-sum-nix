{ pkgs, ... }:
{
  imports = [ ./mk-options.nix ];

  # Set as applicable to you- the person using this flake
  primary-user = "august";
  timezone = "America/Chicago";
  localization = "en_US.UTF-8";

  # The is here for easy updates but will require the flake URI(s) to also be updated
  sumAstroNvim = {
    username = "august";
    nerdfont = "FiraCode";
    nodePackage = pkgs.nodejs_20;
    pythonPackage = pkgs.python311Full;
  };

}
