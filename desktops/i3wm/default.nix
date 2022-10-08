{ config, pkgs, callPackage, ... }:
{

  environment.pathsToLink = [ "/libexec" ];

  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    displayManager = {
      defaultSession = "xfce+i3";
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
      ];
    };
  };

  home-manager.users.august = {
    xdg.configFile."i3/config".source = ./dotfiles/i3/config;
    xdg.configFile."polybar/config.ini".source = ./dotfiles/polybar/config.ini;
    xdg.configFile."rofi/themes/custom.rasi".source = ./dotfiles/rofi/custom.rasi;

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
