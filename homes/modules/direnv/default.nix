{ config, pkgs, home-manager, ... }:
{
  programs.zsh.enable = true;
  home-manager.users.${config.primary-user}.programs = {
    zsh.enable = true;
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
