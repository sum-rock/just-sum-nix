{ config, walker, ... }:
{

  home-manager.users.${config.primaryUser} = {
    imports = [ walker.homeManagerModules.default ];

    programs.walker = {
      enable = true;
      runAsService = true;

      # Configuration options
      config = {
        theme = "default";
        placeholders.default = {
          input = "Search";
          list = "No Results";
        };
        providers.prefixes = [
          {
            provider = "websearch";
            prefix = "+";
          }
          {
            provider = "providerlist";
            prefix = "_";
          }
        ];
        keybinds.quick_activate = [
          "F1"
          "F2"
          "F3"
        ];
      };

      # Custom theme
      themes = {
        "my-theme" = {
          style = builtins.readFile ./walker.css;
          layouts = { };
        };
      };
    };
  };
}
