# Yabia cannot yet be installed with Nix Darwin because macos is frustrating.
# This expression simply manages the config files associated with a functional
# install of yabai. To install Yabia, consult the wiki on their github page. In
# general, one will need to:
#   1.) Disable system inegrety protection 
#   2.) Install yabai via homebrew 
#   3.) Alter the permissions for running yabai on /private/etc/sudoers.d/yabai using visudo 

{ config, pkgs, home-manager, ... }:
{
  home-manager.users."${config.primary-user}" = {
    xdg.configFile = {
      "yabai/yabairc".source = ./yabairc;
    };
  };
}
