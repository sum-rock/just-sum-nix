{ pkgs, config, nixpkgs-unstable, ... }:
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
    gnome-terminal
    geary
    totem
    tali
    totem
  ];

  environment.systemPackages = with pkgs; [
    gnome-themes-extra
    gnome-tweaks
    gtk-engine-murrine
    mutter
  ] ++ [ unstable.magnetic-catppuccin-gtk ];

  users.users.${config.primaryUser} = {
    packages = with pkgs.gnomeExtensions; [
      vitals
      pop-shell
      appindicator
    ];
  };

}
