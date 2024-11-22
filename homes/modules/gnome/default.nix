{ pkgs, config, home-manager, nixpkgs-unstable, ... }:
let
  unstable = import nixpkgs-unstable {
    system = "x86_64-linux";
    config = { };
  };
in
{
  services.libinput.enable = true;
  services.displayManager.defaultSession = "gnome";
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    desktopManager.gnome.enable = true;
    displayManager = {
      gdm.enable = true;
      gdm.wayland = true;
    };
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
    gnome.gnome-tweaks
    gtk-engine-murrine
    gnome.mutter
  ] ++ [ unstable.magnetic-catppuccin-gtk ];

  users.users.${config.primary-user} = {
    packages = with pkgs.gnomeExtensions; [
      vitals
      pop-shell
      appindicator
    ];
  };

}
