{ config, pkgs, home-manager, ... }:
{

  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };
  
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
    pathsToLink = [ "/share/nix-direnv" ];
    systemPackages = with pkgs; [

      # Programing tools
      # ----------------
      python39Full
      python39Packages.isort
      python39Packages.black
      poetry
      nodejs
      yarn
      pre-commit
      tree-sitter
      chromedriver

      # direnv
      # ------
      direnv
      nix-direnv

      # Databases
      # ---------
      postgresql_14
      sqlite

      # Applications
      # ------------
      dbeaver

    ];
  };

}
