{ pkgs, config, ... }:
{
  imports = [
    ./walker
    ./waybar
    ./wlogout
    ./swaylock
  ];

  programs.niri.enable = true;

  security.polkit.enable = true;
  security.pam.services.swaylock = { };

  services = {
    libinput.enable = true;
    gnome.gnome-keyring.enable = true;
    displayManager.gdm.enable = false;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.niri}/bin/niri-session";
          user = config.primaryUser;
        };
      };
    };
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };

  environment.systemPackages = with pkgs; [
    niri
    xwayland-satellite

    awww

    wl-clipboard
    cliphist

    grim
    slurp

    nwg-look
    nwg-displays

    polkit_gnome

    adwaita-icon-theme
    catppuccin-gtk
    catppuccin-cursors.mochaDark

  ];

  home-manager.users.${config.primaryUser} = {

    home.packages = with pkgs; [
      foot
      nautilus
      pavucontrol
      networkmanagerapplet
      blueman
    ];
    gtk = {
      enable = true;
      # Explicit setting to be consistent with upstream changes.
      gtk4.theme = null;
      theme = {
        name = "catppuccin-mocha-mauve-standard";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "mauve" ];
          size = "standard";
          tweaks = [ "normal" ];
          variant = "mocha";
        };
      };
      cursorTheme = {
        name = "catppuccin-mocha-dark-cursors";
        package = pkgs.catppuccin-cursors.mochaDark;
      };
      iconTheme.name = "Adwaita";
    };

    home.pointerCursor = {
      gtk.enable = true;
      name = "catppuccin-mocha-dark-cursors";
      package = pkgs.catppuccin-cursors.mochaDark;
      size = 24;
    };

    xdg.configFile."niri/config.kdl".text = builtins.readFile ./niri.kdl;
    xdg.configFile."foot/foot.ini".text = builtins.readFile ./foot.ini;
  };
}
