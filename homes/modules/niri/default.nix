{ pkgs, config, ... }:
let
  restart-niri-services = pkgs.writeScriptBin "restart-niri-services" ''
    ${builtins.readFile ./restart-niri-services.sh}
  '';
in
{
  imports = [ ./walker.nix ];

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

    walker
    swaylock
    swayidle
    awww
    wlogout

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

    waybar
  ];

  home-manager.users.${config.primaryUser} = {

    home.packages = with pkgs; [
      foot
      nautilus
      pavucontrol
      networkmanagerapplet
      blueman
      restart-niri-services
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
    xdg.configFile."swaylock/config".text = builtins.readFile ./swaylock.ini;
    xdg.configFile."waybar/config".text = builtins.readFile ./waybar-config.json;
    xdg.configFile."waybar/style.css".text = builtins.readFile ./waybar-style.css;
    xdg.configFile."wlogout/style.css".text = (builtins.readFile ./wlogout-style.css) + ''

      #lock     { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png")); }
      #logout   { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png")); }
      #reboot   { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png")); }
      #shutdown { background-image: image(url("${pkgs.wlogout}/share/wlogout-layoutwlogout/icons/shutdown.png")); }
    '';
    xdg.configFile."wlogout/layout".text = builtins.readFile ./wlogout-layout;
  };
}
