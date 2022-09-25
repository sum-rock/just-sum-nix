{ config, pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    font-awesome
  ];

  users.users.august.packages = with pkgs; [ 
    alacritty 
    starship 
  ];

  home-manager.users.august = {

    home.file.".alacritty.yml".source = ./dotfiles/alacritty.yml;
    programs.zsh.initExtra = ''
eval "$(starship init zsh)"
    '';

  };
}
