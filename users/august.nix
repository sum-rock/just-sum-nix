{ config, pkgs, ... }:
{
  imports = [ ./options.nix ];

  config = {
    primary-user = "august";
  };
}
