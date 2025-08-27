{ config, pkgs, home-manager, nixpkgs-unstable, ... }:
let
  unstable = import nixpkgs-unstable {
    system = "aarch64-darwin";
    config = { };
  };
in
{
  imports = [
    home-manager.darwinModules.home-manager
    ./modules/yabai
    ./modules/terminal
    ./modules/ranger
    ./modules/direnv
  ];

  home-dir-path = "/Users/${config.primaryUser}";

  users.users.${config.primaryUser} = {
    home = "${config.home-dir-path}";
    shell = pkgs.fish;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${config.primaryUser} = {
    home = {
      username = "${config.primaryUser}";
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
      neovim = {
        enable = true;
        package = unstable.neovim-unwrapped;
      };
      fish = {
        enable = true;
        shellInit = ''
          set DOCKER "$HOME/.docker/init-bash.sh"
          set EDITOR nvim
          
          set OPENAI_API_KEY $(cat $HOME/.openai)
          set RAINFROG_CONFIG "$HOME/.config/rainfrog"
          
          if  [ -f "$HOME/.profile.custom" ] ; source "$HOME/.profile.custom" ; end
           
          set HOMEBREW "/opt/homebrew/opt/grep/libexec/gnubin"
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
        shellAliases = {
          xvim = "nvim .";
        };
      };
    };
  };
}
