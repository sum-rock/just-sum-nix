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
        pulseaudio
        i3lock-fancy
        i3-gaps
        polybar
        rofi
        pywal
        networkmanager_dmenu
        feh                   # For wallpaper
      ];
    };
  };
  
  home-manager.users.${username} = {
    programs.zsh.shellAliases = {
      reload-polybar = "sh ~/.config/polybar/launch.sh";
    };
    xdg.configFile = {
      "i3/config".source = ./dotfiles/i3/config;
      "rofi/themes/custom.rasi".source = ./dotfiles/rofi/custom.rasi;
      "wallpaper/space-station.jpg".source = ./dotfiles/wallpaper/space-station.jpg;
      "polybar".source = pkgs.symlinkJoin {
        name="polybar";
        paths = [
          ./dotfiles/polybar
          ./dotfiles/polybar/scripts
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

