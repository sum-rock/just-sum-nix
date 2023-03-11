{ config, pkgs, ... }:
{
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
      element-desktop

    ];
  };

}
