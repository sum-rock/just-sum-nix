# This expression relys on having yabai setup correctly. To setup yabai, consult 
# the wiki on their github page. In general, one will need to:
#   1.) Disable system inegrety protection 
#   2.) Alter the permissions for running yabai on /private/etc/sudoers.d/yabai using visudo 

{ config, pkgs, home-manager, ... }:
{

  environment.systemPackages = with pkgs; [ 
    skhd
    yabai
  ];
  services.skhd.enable = true;
  services.yabai.enable = true;

  home-manager.users."${config.primary-user}" = {
    xdg.configFile = {
      "yabai/yabairc".source = ./yabairc;
      "skhd/skhdrc".source = ./skhdrc;
    };
  };
}
