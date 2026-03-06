{ config, home-manager, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [ aerospace ];

  home-manager.users.${config.primaryUser} = {
    programs.aerospace = {
      enable = true;
      launchd.enable = true;

      userSettings = {
        gaps = {
            outer.left = 8;
            outer.bottom = 8;
            outer.top = 8;
            outer.right = 8;
            inner.horizontal = 4;
            inner.vertical = 4;
          };
          mode.main.binding = {
            alt-h = "focus left";
            alt-j = "focus down";
            alt-k = "focus up";
            alt-l = "focus right";
            alt-shift-h = "move left";
            alt-shift-j = "move down";
            alt-shift-k = "move up";
            alt-shift-l = "move right";
          };
          on-window-detected = [
            {
              "if".app-id = "com.apple.finder";
              run = "move-node-to-workspace 9";
            }
            {
              "if" = {
                app-id = "com.apple.systempreferences";
                app-name-regex-substring = "settings";
                window-title-regex-substring = "substring";
                workspace = "workspace-name";
                during-aerospace-startup = true;
              };
              check-further-callbacks = true;
              run = [
                "layout floating"
                "move-node-to-workspace S"
              ];
            }
          ];
        };
      };
    };
  }
