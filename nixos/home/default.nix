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
      };
    };

    programs.home-manager.enable = true;
  };
}
