{ pkgs, ... }:
{
  nix.settings = {
    keep-outputs = true;
    keep-derivations = true;
  };

  programs.zsh.enable = true;

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

  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; } )
  ];
}
