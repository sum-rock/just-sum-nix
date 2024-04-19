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
      stateVersion = "${config.nixos-version}";
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
          set PATH $HOME/.nix-profile/bin /run/current-system/sw/bin /nix/var/nix/profiles/default/bin $PATH
          
          set DOCKER "$HOME/.docker/init-bash.sh"

          set OPENAI_API_KEY $(cat $HOME/.openai)
          
          if  [ -f "$HOME/.profile.custom" ] ; source "$HOME/.profile.custom" ; end
           
          set HOMEBREW "/opt/homebrew/opt/grep/libexec/gnubin"
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
      };
    };
  };
}
