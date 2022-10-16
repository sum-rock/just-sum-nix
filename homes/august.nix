{ pkgs, config, ... }:
{

  users.users.august = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  home-manager.users.august = {

    programs.home-manager.enable = true; 
    home.username = "august";
    home.homeDirectory = "/home/august";

    programs.zsh = {
      enable = true;
      shellAliases = {
      	ls = "ls -la";
        rf = "source ~/.zshrc";
        nix-edit = "cd /home/august/.nix; nvim";
        nix-deploy = "sudo nixos-rebuild switch --flake '/home/august/.nix'";
      };
    };

  };
}
