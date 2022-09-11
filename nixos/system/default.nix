{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./boot.nix
      ./fonts.nix
      ./packages.nix
      ./sway.nix
      ./users.nix
      ./neovim
    ];


  # Open ports in the firewall:
  # ---------------------------
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Network settings:
  # -----------------
  networking.hostName = "nixos-xps"; 
  networking.networkmanager.enable = true;

  # Localizations:
  # --------------
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  
  # Audio:
  # ------
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true; 
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # List services that you want to enable:
  # --------------------------------------
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;


  # Other system settings:
  # ======================

  # Enable screen brightness control
  programs.light.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
