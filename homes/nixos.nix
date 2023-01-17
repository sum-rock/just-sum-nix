{ config, pkgs, home-manager, ... }:
{
  imports = [
    home-manager.nixosModule
    ./modules/terminal
    ./modules/neovim
    ./modules/ranger
    ./modules/gnome
  ];

  primary-user = "august";
  home-dir-path = "/home/august";

  # Home manager settings
  #   These allow a rebuild without raising the "impure" warning. See issue 
  #   here https://github.com/divnix/digga/issues/30
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${config.primary-user} = {
    programs.home-manager.enable = true; 
    home.stateVersion = "22.11";
    home.username = "${config.primary-user}";
    home.homeDirectory = "/home/${config.primary-user}";
    programs.zsh = {
      enable = true;
      initExtra = ''
        export EDITOR="/run/current-system/sw/bin/nvim"
        export NIX_CONFIG_PATH="${config.home-dir-path}/.nixpkgs"
      '';
      shellAliases = {
        nix-edit = "cd $NIX_CONFIG_PATH; nvim .";
        nixos-rebuild-flake-test = "sudo nixos-rebuild test --flake $NIX_CONFIG_PATH";
        nixos-rebuild-flake = "sudo nixos-rebuild switch --flake $NIX_CONFIG_PATH";
        modify-sops = "cd $NIX_CONFIG_PATH; nix-shell -p sops --run \"sops secrets/secrets.yaml\"";
      };
    };
  };
}
