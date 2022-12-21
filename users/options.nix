{ config, pkgs, ... }:
{
  options = {
    primary-user = pkgs.lib.mkOption {
      description = "Username for the primary user.";
    };
  };
}
