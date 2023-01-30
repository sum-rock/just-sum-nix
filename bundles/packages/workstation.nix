{ config, pkgs, home-manager, ... }:
{
  programs.zsh.enable = true;
  home-manager.users.${config.primary-user}.programs = {
    zsh.enable = true;
      direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        warn_timeout = "30m";
      };
    };
  };

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

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
      poetry
      postgresql_14
      tree-sitter
      nodejs
      yarn

      # Applications
      # ------------
      dbeaver

    ];
  };

}
