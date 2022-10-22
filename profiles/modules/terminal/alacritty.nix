{ config, pkgs, ... }:
{

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      font-awesome
    ];
  };

  environment.systemPackages = with pkgs; [
    alacritty 
    starship 
  ];

}
