{ config, pkgs, home-manager, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    ./modules/terminal
    ./modules/ranger
    ./modules/gnome
    ./modules/direnv
  ];

  home-dir-path = "/home/${config.primary-user}";
  home-manager.backupFileExtension = "bak";

  # This isn't working in darwin but it should be in the terminal module 
  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Lilex" ]; })
      font-awesome
    ];
  };

  home-manager.users.${config.primary-user} = {
    services = {
      nextcloud-client.enable = true;
    };
    home = {
      stateVersion = "24.05";
      username = "${config.primary-user}";
      homeDirectory = "/home/${config.primary-user}";
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
        '';
      };
    };
  };
}
