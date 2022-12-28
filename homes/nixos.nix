{ config, pkgs, home-manager, ... }:
{
  primary-user = "august";
  home-dir-path = "/home/august";

  imports = [
    home-manager.nixosModule
    ./modules/terminal
    ./modules/neovim
    ./modules/ranger
    ./modules/gnome
  ];

  # Home manager settings
  #   These allow a rebuild without raising the "impure" warning. See issue 
  #   here https://github.com/divnix/digga/issues/30
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # User setup
  # ----------
  users.users.${config.primary-user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "networkmanager" "plugdev" "openrazer" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };
  home-manager.users.${config.primary-user} = {
    programs.home-manager.enable = true; 
    home.stateVersion = "22.11";
    home.username = "${config.primary-user}";
    home.homeDirectory = "/home/${config.primary-user}";
    programs.zsh = {
      enable = true;
      initExtra = ''
        export EDITOR="/run/current-system/sw/bin/nvim"
        export NIX_CONFIG_PATH="/home/${config.primary-user}/.nixpkgs"
      '';
      shellAliases = {
        nix-edit = "cd $NIX_CONFIG_PATH; nvim .";
        nix-deploy = "sudo nixos-rebuild switch --flake $NIX_CONFIG_PATH";
        modify-sops = "cd $NIX_CONFIG_PATH; nix-shell -p sops --run \"sops secrets/secrets.yaml\"";
      };
    };
  };
}
