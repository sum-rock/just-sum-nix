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
      tree-sitter

      # Applications
      # ------------
      dbeaver

    ];
  };

}
