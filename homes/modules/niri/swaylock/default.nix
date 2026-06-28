{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    swaylock
    swayidle
  ];

  home-manager.users.${config.primaryUser} = {
    xdg.configFile."swaylock/config".text = builtins.readFile ./swaylock.ini;
  };
}
