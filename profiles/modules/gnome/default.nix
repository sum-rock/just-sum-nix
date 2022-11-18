{ pkgs, config, username,... }:
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

  users.users.${username} = {
    packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      desktop-cube
      vitals
      clipboard-indicator
      pop-shell
    ];
  };

}
