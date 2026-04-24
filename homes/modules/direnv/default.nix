{ config, pkgs, home-manager, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      direnv = prev.direnv.overrideAttrs (_: {
        # this is here to address build errors on macos. TODO: remove when resolved 
        doCheck = false;
      });
    })
  ];
  home-manager.users.${config.primaryUser}.programs = {
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
