{ config, pkgs, ... }:
{
  options = {
    primary-user = pkgs.lib.mkOption {
      description = "Username for the primary user.";
    };
    home-dir-path = pkgs.lib.mkOption {
      description = "Home directory path for the primary user.";
    };
  };
}

