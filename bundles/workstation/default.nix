# Configs common to all workstation installations of Nixos
# Assumptions:
#   - GUI will be installed

{ config, pkgs, ... }:

{
  imports = 
  [
    ../common
    ../modules/alacritty
    ../modules/neovim
    ../modules/sway
  ];
  
  # Programs
  # --------
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    python310
    tmux
    ranger
    gitui
    pciutils
  ];

  # Localization
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  # Audio:
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true; 
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Users
  # -----
  users.users.august = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };

  home-manager.users.august = {

    programs.home-manager.enable = true; 
    home.username = "august";
    home.homeDirectory = "/home/august";

    programs.zsh = {
      enable = true;
      shellAliases = {
      	xl = "ls -la";
        rf = "source ~/.zshrc";
        nix-edit = "cd /home/august/repositories/sum-nixos; nvim";
        nix-deploy = "sudo nixos-rebuild switch --impure --flake '/home/august/repositories/sum-nixos/'";
      };
    };

  };
}
