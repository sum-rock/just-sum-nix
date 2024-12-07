{ config, pkgs, home-manager, gruvbox-gtk, ... }:
{
  imports = [
    home-manager.darwinModules.home-manager
    ./modules/yabai
    ./modules/terminal
    ./modules/ranger
    ./modules/direnv
  ];

  home-dir-path = "/Users/${config.primary-user}";

  users.users.${config.primary-user} = {
    home = "${config.home-dir-path}";
    shell = pkgs.fish;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${config.primary-user} = {
    home = {
      username = "${config.primary-user}";
      homeDirectory = "${config.home-dir-path}";
      stateVersion = "24.05";
      file = {
        ".wallpapers" = {
          source = ./wallpapers/catppuccin;
          recursive = true;
        };
      };
    };
    programs = {
      home-manager.enable = true;
      fish = {
        enable = true;
        shellInit = ''
          set DOCKER "$HOME/.docker/init-bash.sh"
          set EDITOR nvim
          
          set OPENAI_API_KEY $(cat $HOME/.openai)
          
          if  [ -f "$HOME/.profile.custom" ] ; source "$HOME/.profile.custom" ; end
           
          set HOMEBREW "/opt/homebrew/opt/grep/libexec/gnubin"
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
      };
    };
  };
}
