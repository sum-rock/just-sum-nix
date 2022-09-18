{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.august = {
    programs.home-manager.enable = true;
    
    home.username = "august";
    home.homeDirectory = "/home/august";

    programs.zsh = {
      enable = true;
      initExtra = ''
eval "$(starship init zsh)"
      '';
      shellAliases = {
      	xl = "ls -la";
        rf = "source ~/.zshrc";
        menu = "sway-launcher-desktop";
        nix-edit = "cd /home/august/repositories/sum-nixos; nvim .";
        nix-deploy = "/home/august/repositories/sum-nixos/bin/sum-nixos.sh deploy";
      };
    };

    # Dotfiles
    xdg.configFile."sway/config".source = ./dotfiles/sway/config;
    xdg.configFile."waybar/config".source = ./dotfiles/waybar/config;
    xdg.configFile."waybar/style.css".source = ./dotfiles/waybar/style.css;
    home.file.".alacritty.yml".source = ./dotfiles/alacritty.yml;
  };
}
