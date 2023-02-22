{ pkgs, config, home-manager, gruvbox-gtk, catppuccin-gtk, ... }:
let
  config-gtk_4-theme = {
    catppuccin = {
      "gtk-4.0" = {
        source = "${catppuccin-gtk}/themes/Catppuccin-Mocha-BL/gtk-4.0";
        recursive = true;
      };
    };
    gruvbox = {
      "gtk-4.0" = {
        source = "${gruvbox-gtk}/themes/Gruvbox-Dark-BL/gtk-4.0";
        recursive = true;
      };
    };
  };
  config-gtk_3-theme = {
    catppuccin = {
      ".themes/catppuccin-mocha" = {
        source = "${catppuccin-gtk}/themes/Catppuccin-Mocha-BL";
        recursive = true;
      };
    };
    gruvbox = {
      ".themes/gruvbox-dark" = {
        source = "${gruvbox-gtk}/themes/Gruvbox-Dark-BL";
        recursive = true;
      };
    };
  };
in
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome.gnome-terminal
    gnome.geary
    gnome.totem
    gnome.tali
    gnome.totem
  ];

  environment.systemPackages = with pkgs; [ 
    gnome.gnome-themes-extra
    gtk-engine-murrine
  ];

  users.users.${config.primary-user} = {
    packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      desktop-cube
      vitals
      clipboard-indicator
      pop-shell
    ];
  };

  # For fractional scalling this has to be run. It is unclear how to get this into nix
  # gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

  home-manager.users.${config.primary-user} = {
    xdg.configFile = config-gtk_4-theme.${config.theme};
    home.file = config-gtk_3-theme.${config.theme};
    # This should work but it makes the home-manager service timeout
    # ".icons" = {
    #   source = "${gruvbox-gtk}/icons/Gruvbox-Dark";
    #   recursive = true;
    # };
  };
}
