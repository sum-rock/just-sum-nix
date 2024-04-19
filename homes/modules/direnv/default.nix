{ config, pkgs, home-manager, ... }:
{
  home-manager.users.${config.primary-user}.programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        warn_timeout = "30m";
      };
    };
  };
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';
}
