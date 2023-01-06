{ config, pkgs, home-manager, ... }:
{
  programs.zsh.enable = true;
  home-manager.users.${config.primary-user}.programs = {
    zsh.enable = true;
    direnv = {
     enable = true;
     nix-direnv.enable = true;
    };
  };

  services.postgresql.enable = false;

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment = {
    systemPackages = with pkgs; [

      # Programing tools
      # ----------------
      python39Full
      python39Packages.isort
      python39Packages.black
      tree-sitter

      # direnv
      # ------
      direnv
      nix-direnv

      # Applications
      # ------------
      dbeaver

    ];
  };

}
