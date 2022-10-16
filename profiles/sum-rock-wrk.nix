{ config, pkgs, ... }:
{

  # Home manager settings
  # ---------------------
  # These allow a rebuild without raising the "impure" warning. See issue 
  # here https://github.com/divnix/digga/issues/30
  useGlobalPkgs = true;
  useUserPackages = true;

  # User setup
  # ----------
  # programs.home-manager.enable = true; 
  home.username = "august";
  home.homeDirectory = "/home/august";
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "ls -la";
      rf = "source ~/.zshrc";
      nix-edit = "cd /home/august/.nix; nvim";
      nix-deploy = "darwin-rebuild switch --flake '/home/august/.nix'";
      lsx = "exa --long --all --header --group --git --icons --time-style=long-iso"; 
    };
  };
}