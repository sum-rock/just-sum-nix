{ config, pkgs, callPackage, ... }:
{
  environment.pathsToLink = [ "/libexec" ];

  services.picom.enable = true;

  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;

    displayManager = {
      defaultSession = "none+i3";
      lightdm = {
        enable = true;
      };
    };

    windowManager = {
      i3.enable = true;
      i3.package = pkgs.i3-gaps;
      i3.extraPackages = with pkgs; [
        i3lock-fancy
        i3-gaps
        polybar
        rofi
        pywal
        networkmanager_dmenu
        feh   # For wallpaper
      ];
    };
  };

  home-manager.users.august = {
    xdg.configFile."i3/config".source = ./dotfiles/i3/config;
    xdg.configFile."rofi/themes/custom.rasi".source = ./dotfiles/rofi/custom.rasi;
    xdg.configFile."wallpaper/space-station.jpg".source = ./dotfiles/wallpaper/space-station.jpg;
    xdg.configFile."polybar".source = pkgs.symlinkJoin {
      name = "ploybar-symlinks";
      paths = [
        ./dotfiles/polybar
        ./dotfiles/polybar/scripts
      ];
    };

#    xdg.configFile."polybar".source = pkgs.symlinkJoin {
#      name = "polybar-symlinks";
#      paths = 
#        let
#          polybar-themes = pkgs.fetchFromGitHub {
#            owner = "adi1090x";
#            repo = "polybar-themes";
#            rev = "master";
#            sha256 = "sha256-wABcQ4HSpoa4closylaVRAYGK+38CA7mepZWPYejXp0="; # NOTE: From the output of the nix build
#          };
#        in
#        [
#          "${polybar-themes}/fonts"
#          "${polybar-themes}/simple"
#        ];
#    };

    programs.rofi = {
      enable = true;
      font = "Iosevka 12";
      theme = "custom";
      plugins = [
        pkgs.rofi-emoji
        pkgs.rofi-calc
        pkgs.rofi-power-menu
      ];
      extraConfig = {
        modi = "drun,filebrowser,window";
        dpi = 180;
        show-icons = true;
        sort = true;
        matching = "fuzzy";
      };
    }; 

  };
}
