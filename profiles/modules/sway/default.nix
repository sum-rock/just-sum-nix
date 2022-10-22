# Requires the Workstation Bundle

{ config, pkgs, ...  }:

{

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    dbus = {
      enable = true;
    };
    xserver.displayManager = {
      gdm.enable = true;
      gdm.wayland = false;  # hmmm is this right?
    };
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    gtkUsePortal = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      wl-clipboard
      bemenu
      slurp
      sway-launcher-desktop
      swaylock-effects
      swayidle
      waybar
    ];
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };

  programs.waybar.enable = true;

  # MOVE TO A PROFILE
  # -----------------
  # home-manager.users.august = {
  #   xdg.configFile."sway/config".source = ./dotfiles/sway/config;
  #   xdg.configFile."waybar/config".source = ./dotfiles/waybar/config;
  #   xdg.configFile."waybar/style.css".source = ./dotfiles/waybar/style.css;
  # };
}
