{ pkgs, config, home-manager, catppuccin-gtk, ... }:
{
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager = {
      gdm.enable = true;
      gdm.wayland = true;
      defaultSession = "gnome";
    };
    desktopManager.gnome.enable = true;
    libinput.enable = true;
  };

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
      pop-shell
      appindicator
    ];
  };

  # TODO: For fractional scalling this has to be run. Make post install script 
  # gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

  home-manager.users.${config.primary-user} = {
    # Covers GTK 4.0 compatability
    xdg.configFile = {
      "gtk-4.0" = {
        source = "${catppuccin-gtk}/themes/Catppuccin-Mocha-BL/gtk-4.0";
        recursive = true;
      };
    };
    # For GTK 3.0 compatability
    home.file = {
      ".themes/catppuccin-mocha" = {
        source = "${catppuccin-gtk}/themes/Catppuccin-Mocha-BL";
        recursive = true;
      };
    };
  };
}
