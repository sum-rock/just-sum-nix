{ config, pkgs, ... }:
{
  # Set allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    neovim-unwrapped    
    wget
    git
    python310
    nodejs
    yarn
    tmux
    ranger
    gitui
    starship
    zsh
  ];
}
