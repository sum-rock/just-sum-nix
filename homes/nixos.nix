{ config, pkgs, home-manager, ... }:
let
  wallpapers = {
    catppuccin = ./wallpapers/catppuccin;
    gruvbox = ./wallpapers/gruvbox;
  };
in
{
  imports = [
    home-manager.nixosModule
    ./modules/terminal
    ./modules/neovim
    ./modules/ranger
    ./modules/gnome
    ./modules/direnv
  ];

  home-dir-path = "/home/${config.primary-user}";

  # Home manager settings
  #   These allow a rebuild without raising the "impure" warning. See issue 
  #   here https://github.com/divnix/digga/issues/30
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

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
      stateVersion = "${config.nixos-version}";
      username = "${config.primary-user}";
      homeDirectory = "/home/${config.primary-user}";
      file = {
        ".wallpapers" = {
          source = "${wallpapers.${config.theme}}";
          recursive = true;
        };
      };
    };
    programs = {
      home-manager.enable = true;
      zsh = {
        enable = true;
      };
    };
  };
}
