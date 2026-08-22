{
  pkgs,
  config,
  lib,
  noctalia,
  noctalia-greeter,
  ...
}:
let
  niriDebugConfig = ''
    debug {
        // Allows notification actions and window activation from Noctalia.
        honor-xdg-activation-with-invalid-serial
    ${lib.optionalString (config.networking.hostName == "legion") ''
      // The Legion's dock outputs are wired to the NVIDIA GPU. Rendering
      // there avoids cross-GPU atomic modeset failures when docked.
      render-drm-device "/dev/dri/by-path/pci-0000:01:00.0-render"
      wait-for-frame-completion-before-queueing
    ''}
    }
  '';
in
{
  imports = [
    noctalia.nixosModules.default
    noctalia-greeter.nixosModules.default
  ];

  programs = {
    niri.enable = true;
    noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };
    noctalia-greeter = {
      enable = true;
      settings = {
        session.default = "niri";
        user.default = config.primaryUser;
        appearance = {
          password_style = "default";
          hide_logo = false;
        };
        idle.timeout = 300;
        cursor = {
          theme = "catppuccin-mocha-dark-cursors";
          size = 24;
          path = "${pkgs.catppuccin-cursors.mochaDark}/share/icons";
        };
        keyboard = {
          layout = "us";
          numlock = true;
        };
        auth.allow_empty_password = false;
      };
    };
  };

  security.polkit.enable = true;

  services = {
    libinput.enable = true;
    gnome.gnome-keyring.enable = true;
    displayManager.gdm.enable = false;
    greetd = {
      enable = true;
      settings.default_session.user = "greeter";
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

    wl-clipboard

    nwg-look
    nwg-displays

    adwaita-icon-theme
    catppuccin-gtk
    catppuccin-cursors.mochaDark

  ];

  home-manager.users.${config.primaryUser} = {

    home.packages = with pkgs; [
      foot
      nautilus
      pavucontrol
    ];

    imports = [ noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      systemd.enable = false;
      settings = {
        storage.key_source = "secret-service";

        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Catppuccin";
        };

        shell = {
          font_family = "Lilex Nerd Font";
          offline_mode = false;
          external_ip_enabled = false;
          telemetry_enabled = false;
          setup_wizard_enabled = false;
          polkit_agent = true;
          settings_show_advanced = true;
          settings_window_translucent = true;
          show_location = false;
          screen_time_enabled = false;
          clipboard_enabled = true;
          clipboard_keep_from_closed_apps = false;
          clipboard_history_max_entries = 100;
          clipboard_confirm_clear_history = true;
          greeter_sync.auto_sync = false;

          panel = {
            transparency_mode = "glass";
            borders = true;
            shadow = true;
            launcher_placement = "floating";
            clipboard_placement = "floating";
            control_center_placement = "attached";
            wallpaper_placement = "attached";
            session_placement = "attached";
            polkit_placement = "floating";
            launcher_position = "center";
            clipboard_position = "center";
            polkit_position = "center";
          };

          launcher = {
            categories = true;
            show_icons = true;
            sort_by_usage = true;
            fetch_exchange_rates = false;
          };

          screenshot = {
            save_to_file = true;
            directory = "/home/${config.primaryUser}/Pictures";
            copy_to_clipboard = true;
            freeze_screen = true;
          };
        };

        bar = {
          order = [ "main" ];
          main = {
            enabled = true;
            position = "top";
            reserve_space = true;
            layer = "top";
            thickness = 38;
            background_opacity = 0.78;
            border_width = 1.0;
            radius = 14;
            margin_ends = 12;
            margin_edge = 8;
            padding = 12;
            widget_spacing = 5;
            capsule = true;
            capsule_opacity = 0.65;
            start = [
              "launcher"
              "workspaces"
              "active_window"
            ];
            center = [ "clock" ];
            end = [
              "media"
              "sysmon"
              "tray"
              "privacy"
              "notifications"
              "clipboard"
              "network"
              "bluetooth"
              "volume"
              "brightness"
              "battery"
              "power_profile"
              "control-center"
              "session"
            ];
          };
        };

        dock = {
          enabled = true;
          position = "bottom";
          pinned = [
            "firefox"
            "foot"
            "org.gnome.Nautilus"
          ];
          show_running = true;
          auto_hide = true;
          smart_auto_hide = false;
          reserve_space = false;
          layer = "overlay";
          background_opacity = 0.82;
          margin_edge = 8;
          magnification = true;
        };

        control_center.shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "power_profile"; }
          { type = "notification"; }
          { type = "wallpaper"; }
          { type = "session"; }
        ];

        desktop_widgets.enabled = false;

        wallpaper = {
          enabled = true;
          directory = "/home/${config.primaryUser}/.wallpapers";
          default.path = "/home/${config.primaryUser}/.wallpapers/catppuccin_3.png";
          fill_mode = "crop";
          transition = [
            "fade"
            "wipe"
            "disc"
            "zoom"
          ];
          transition_duration = 900;
          automation.enabled = false;
        };

        backdrop = {
          enabled = true;
          blur_intensity = 0.5;
          tint_intensity = 0.3;
        };

        idle = {
          behavior_order = [
            "lock"
            "screen-off"
          ];
          pre_action_fade_seconds = 2.0;
          behavior = {
            lock = {
              enabled = true;
              timeout = 600;
              action = "lock";
            };
            screen-off = {
              enabled = true;
              timeout = 900;
              action = "screen_off";
            };
          };
        };

        lockscreen = {
          enabled = true;
          lock_before_suspend = true;
          fingerprint = false;
          allow_empty_password = false;
          blurred_desktop = false;
          blur_intensity = 0.5;
          tint_intensity = 0.3;
        };

        notification = {
          enable_daemon = true;
          position = "top_right";
          layer = "top";
          background_opacity = 0.9;
          border = true;
          history_retention_hours = 168;
        };

        osd = {
          position = "top_center";
          background_opacity = 0.9;
          border = true;
        };

        location = {
          auto_locate = false;
          address = "";
        };
        weather.enabled = false;
        calendar.enabled = false;
        system.monitor.enabled = true;
      };
    };

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

    xdg.configFile."niri/config.kdl".text = builtins.readFile ./niri.kdl + niriDebugConfig;
    xdg.configFile."foot/foot.ini".text = builtins.readFile ./foot.ini;
  };
}
