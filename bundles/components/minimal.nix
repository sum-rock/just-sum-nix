# Configs that will be common to all installations of Nix.
# Assumtions:
# -----------
#  - These are applicable in both workstation and server environments.

{ config, pkgs, ... }:
{
  
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
  
  # Packages
  # --------
  # Bare minimum packages for workstations and servers.
  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    zsh
    networkmanager
    psmisc    # Includes ps commands that are commonly used. (e.g., killall)
  ];

  # Internet stuff
  # ==============
  
  # Ports should be opened in either the workstation or server bundles
  networking.firewall.enable = true;
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
