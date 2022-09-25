{ config, pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    font-awesome
  ];

  user.users.august.packages = with pkgs; [ alacritty ];
  home.file.".alacritty.yml".source = ./dotfiles/alacritty.yml;

}
