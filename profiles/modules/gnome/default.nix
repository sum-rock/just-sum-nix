{ pkgs, config, home-manager, gruvbox-gtk, username,... }:
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

  users.users.${username} = {
    packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      desktop-cube
      vitals
      clipboard-indicator
      pop-shell
    ];
  };

  home-manager.users.${username} = {
    xdg.configFile = {
      "gtk-4.0".source = "${gruvbox-gtk}/themes/Gruvbox-Dark-BL/gtk-4.0";
    };
    home.file = { 
      ".themes/gruvbox-dark" = {
        source = "${gruvbox-gtk}/themes/Gruvbox-Dark-BL";
        recursive = true;
      };
      ".wallpapers/gruvbox12.png" = {
        source = "${gruvbox-gtk}/wallpapers/gruvbox12.png";
      };
      # This should work but it makes the home-manager service timeout
      # ".icons" = {
      #   source = "${gruvbox-gtk}/icons/Gruvbox-Dark";
      #   recursive = true;
      # };
    };
  };
}
