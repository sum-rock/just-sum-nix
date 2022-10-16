{ pkgs, config, ... }:
{

  imports = 
  [
    ./components/alacritty
    ./components/neovim
  ];
  

  # System
  # ------
  # Must declare state here and it must match the release channel in flake.nix
  system.stateVersion = "22.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Home manager settings
  # ---------------------
  # These allow a rebuild without raising the "impure" warning. See issue 
  # here https://github.com/divnix/digga/issues/30
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;


  # User setup
  # ----------
  home-manager.users.august = {
    programs.home-manager.enable = true; 
    home.username = "august";
    home.homeDirectory = "/home/august";
    programs.zsh = {
      enable = true;
      shellAliases = {
        ls = "ls -la";
        rf = "source ~/.zshrc";
        nix-edit = "cd /home/august/.nix; nvim";
        nix-deploy = "sudo nixos-darwin switch --flake '/home/august/.nix'";
        lsx = "exa --long --all --header --group --git --icons --time-style=long-iso"; 
      };
    };
  };
  

  # Programs
  # --------
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    python310
    neofetch
    tmux
    btop
    ranger
    gitui
    exa           # Better than ls
    ripgrep
    wget
    git
  ];
}
