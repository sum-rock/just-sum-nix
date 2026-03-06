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
    ./modules/terminal
    ./modules/ranger
    ./modules/direnv
  ];

  home-dir-path = "/Users/${config.primaryUser}";

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.lilex
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${config.primaryUser} = {
    home = {
      username = "${config.primaryUser}";
      homeDirectory = "${config.home-dir-path}";
      stateVersion = "25.11";
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

          if [ -f "$HOME/.profile.custom" ]
            source "$HOME/.profile.custom"
          end

          set HOMEBREW "/opt/homebrew/opt/grep/libexec/gnubin"
          if [ -f "/opt/homebrew/bin/brew" ]
            eval "$(/opt/homebrew/bin/brew shellenv)"
          end
        '';
        shellAliases = {
          xvim = "nvim .";
        };
      };
    };
  };
}
