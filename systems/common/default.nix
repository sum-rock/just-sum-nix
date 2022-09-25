{ config, pkgs, ... }:
{

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    python310
    tmux
    ranger
    gitui
    starship
    zsh
  ];

  users.users.august = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };

  hm-nixos.users.august = {

    programs.hm-nixos.enable = true; 
    home.username = "august";
    home.homeDirectory = "/home/august";

    programs.zsh = {
      enable = true;
      initExtra = ''
eval "$(starship init zsh)"
      '';
      shellAliases = {
      	xl = "ls -la";
        rf = "source ~/.zshrc";
        nix-edit = "cd /home/august/repositories/sum-nixos; nvim .";
        nix-deploy = "/home/august/repositories/sum-nixos/bin/sum-nixos.sh deploy";
      };
    };

  };

}
