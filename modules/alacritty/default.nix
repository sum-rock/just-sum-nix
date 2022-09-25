{ config, pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    font-awesome
  ];

  users.users.august.packages = with pkgs; [ alacritty ];
  home-manager.users.august = {
    home.file.".alacritty.yml".source = ./dotfiles/alacritty.yml;
  };
}
