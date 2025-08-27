{ config, pkgs, home-manager, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    ./modules/terminal
    ./modules/ranger
    ./modules/gnome
    ./modules/direnv
  ];

  home-dir-path = "/home/${config.primaryUser}";
  home-manager.backupFileExtension = "bak";

  # This isn't working in darwin but it should be in the terminal module 
  fonts = {
    packages = with pkgs; [
      font-awesome
      nerd-fonts.lilex
    ];
  };

  home-manager.users.${config.primaryUser} = {
    services = {
      nextcloud-client.enable = true;
    };
    home = {
      stateVersion = "24.05";
      username = "${config.primaryUser}";
      homeDirectory = "/home/${config.primaryUser}";
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
          set OPENAI_API_KEY $(cat $HOME/.openai)
          set RAINFROG_CONFIG "$HOME/.config/rainfrog"
        '';
      };
    };
    programs.fish.shellAliases = {
      xvim = "steam-run nvim .";
    };
  };
}
