{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ waybar ];

  home-manager.users.${config.primaryUser} = {
    xdg.configFile."waybar/config".text = builtins.readFile ./config.json;
    xdg.configFile."waybar/style.css".text = builtins.readFile ./style.css;
  };
}
