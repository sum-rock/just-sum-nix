{ 
  config, 
  pkgs, 
  home-manager, 
  zsh-autocomplete, 
  gruvbox-gtk,
  ranger-devicons,
  tmux-plugin-manager,
  ... 
}:
let
  # Username for this profile
  username = "august"; 

  module-namespace = {
    pkgs = pkgs;
    config = config;
    home-manager = home-manager;
    zsh-autocomplete = zsh-autocomplete; 
    gruvbox-gtk = gruvbox-gtk;
    ranger-devicons = ranger-devicons;
    tmux-plugin-manager = tmux-plugin-manager;
    username = username;
  };
  
  # Loads username and args to these modules
  terminal = ( import ./modules/terminal module-namespace );
  neovim = ( import ./modules/neovim module-namespace );
  ranger = ( import ./modules/ranger module-namespace );
  gnome = ( import ./modules/gnome module-namespace );
in
{
  imports = [
    home-manager.nixosModule
    terminal
    neovim
    ranger
    gnome
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
    extraGroups = [ "wheel" "video" "networkmanager" "plugdev" "openrazer" ];
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
        nix-deploy = "sudo nixos-rebuild switch --flake '/home/${username}/.nixpkgs'";
      };
    };
  };
}
