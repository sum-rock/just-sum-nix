{ config, pkgs, callPackage, ... }:
{
  environment.pathsToLink = [ "/libexec" ];

  services.picom.enable = true;

  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;

    displayManager = {
      defaultSession = "none+i3";
      lightdm = {
        enable = true;
      };
    };

    windowManager = {
      i3.enable = true;
      i3.package = pkgs.i3-gaps;
      i3.extraPackages = with pkgs; [
        i3lock-fancy
        i3-gaps
        polybar
        rofi
        pywal
        networkmanager_dmenu
        feh   # For wallpaper
      ];
    };
  };
}