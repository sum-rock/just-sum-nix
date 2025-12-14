{ pkgs, ... }:
{
  imports = [ ./mk-options.nix ];

  # Set as applicable to you- the person using this flake
  primaryUser = "august";
  timezone = "America/Chicago";
  localization = "en_US.UTF-8";

  sumAstroNvim = {
    username = "august";
    nerdfont = pkgs.nerd-fonts.lilex;
    nodePackage = pkgs.nodejs_20;
    pythonPackage = pkgs.python314;
  };

}
