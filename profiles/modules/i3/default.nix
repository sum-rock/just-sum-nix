{ config, pkgs, home-manager, username, ... }:
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
  
  home-manager.users.${username} = {
    xdg.configFile = {
      "i3/config".source = ./dotfiles/i3_wm/i3/config;
      "rofi/themes/custom.rasi".source = ./dotfiles/i3/rofi/custom.rasi;
      "wallpaper/space-station.jpg".source = ./dotfiles/i3/wallpaper/space-station.jpg;
      "polybar".source = pkgs.symlinkJoin {
        name = "ploybar-symlinks";
        paths = [
          ./dotfiles/i3/polybar
          ./dotfiles/i3/polybar/scripts
        ];
      };
    };
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

