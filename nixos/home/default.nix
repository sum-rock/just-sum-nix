{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.august = {

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
        nix-edit = "nvim /home/august/repositories/sum-nixos";
        nix-deploy = "/home/august/repositories/sum-nixos/bin/sum-nixos.sh deploy";
      };
    };

    programs.home-manager.enable = true;
  };
}
