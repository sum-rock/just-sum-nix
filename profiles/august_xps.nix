{ config, pkgs, ... }:
{
  home-manager.users.august = {
    users.august = {
      programs.home-manager.enable = true; 
      home.username = "august";
      home.homeDirectory = "/home/august";
      programs.zsh = {
        enable = true;
        shellAliases = {
          ls = "ls -la";
          rf = "source ~/.zshrc";
          lsx = "exa --long --all --header --group --git --icons --time-style=long-iso"; 
          nix-edit = "cd /home/august/.nix; nvim";
          nix-deploy = "sudo nixos-rebuild switch --flake '/home/august/.nix'";
        };
      };
    };
    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./dotfiles/alacritty/alacritty.yml;
      "nvim/coc-settings.json".source = ./dotfiles/nvim/coc-settings.json;
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
