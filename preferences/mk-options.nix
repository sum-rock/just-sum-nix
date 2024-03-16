{ config, pkgs, ... }:
{
  options = {
    primary-user = pkgs.lib.mkOption {
      description = "Username for the primary user.";
    };
    home-dir-path = pkgs.lib.mkOption {
      description = "Home directory path for the primary user.";
    };
    timezone = pkgs.lib.mkOption {
      description = "The timezone the system should adopt";
    };
    localization = pkgs.lib.mkOption {
      description = "The unicode encoding version that should be used";
    };
    nixos-version = pkgs.lib.mkOption {
      description = "The verison of NixOs and home-manager used in the flake inputs.";
    };
    githubAddress = pkgs.lib.mkOption {
      description = "The github address where your fork of this repo lives.";
    };
    theme = pkgs.lib.mkOption {
      description = ''
        The name of the theme you wish to use. 
        Options: "gruvbox" or "catppuccin"
      '';
    };
  };
}
