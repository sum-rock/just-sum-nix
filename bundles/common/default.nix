# Configs that will be common to all installations of Nix
# Assumtions:
#  - These are applicable in both workstation and server environments.

{ config, pkgs, ... }:
{

  system.stateVersion = "22.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    zsh
    networkmanager
  ];

  # Firewall:
  networking.firewall.enable = true;

  # Networkmanager
  networking.networkmanager.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}
