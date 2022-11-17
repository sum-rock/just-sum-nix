{ config, pkgs, home-manager, zsh-autocomplete, ... }:
let
  # Username for this profile
  username = "august"; 

  module-namespace = {
    pkgs = pkgs;
    config = config;
    home-manager = home-manager;
    username = username;
    zsh-autocomplete = zsh-autocomplete; 
  };
  
  # Loads username and args to these modules
  terminal = ( import ./modules/terminal module-namespace );
  neovim-custom = ( import ./modules/neovim module-namespace );
  ranger-custom = ( import ./modules/ranger module-namespace );
  i3-custom = ( import ./modules/i3 module-namespace );
in
{
  imports = [
    home-manager.nixosModule
    terminal
    i3-custom
    neovim-custom
    ranger-custom
  ];

  # Home manager settings
  #   These allow a rebuild without raising the "impure" warning. See issue 
  #   here https://github.com/divnix/digga/issues/30
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # User setup
  # ----------
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };
  home-manager.users.${username} = {
    programs.home-manager.enable = true; 
    home.stateVersion = "22.11";
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";
    programs.zsh = {
      enable = true;
      shellAliases = {
        nix-edit = "cd /home/${username}/.nix; nvim";
        nix-deploy = "sudo nixos-rebuild switch --flake '/home/${username}/.nix'";
      };
    };
  };
}
