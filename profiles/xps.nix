{ config, pkgs, home-manager, zsh-autocomplete, ... }:
let
  # Username for this profile
  username = "august"; 
  
  # Loads username and args to these modules
  terminal = ( 
    import ./modules/terminal { 
      pkgs = pkgs; 
      config = config; 
      zsh-autocomplete = zsh-autocomplete; 
      home-manager = home-manager;
      username = username;
    } 
  );
  neovim-custom = (
    import ./modules/neovim {
      pkgs = pkgs;
      config = config;
      home-manager = home-manager;
      username = username;
    }
  );
in
{

  # Home manager settings
  #   These allow a rebuild without raising the "impure" warning. See issue 
  #   here https://github.com/divnix/digga/issues/30
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # User setup
  # ----------
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };
  home-manager.users.${username} = {
    users.${username} = {
      programs.home-manager.enable = true; 
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
