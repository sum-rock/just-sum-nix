{ pkgs, ... }:

{
  # Global default for sqlfluff (formatter for SQL in programs.zed-editor
  # below). Projects needing a specific dialect (postgres, mysql, ...) can
  # add their own .sqlfluff to override this.
  home.file.".sqlfluff".text = ''
    [sqlfluff]
    dialect = ansi

    [sqlfluff:indentation]
    tab_space_size = 2
  '';

  xdg.configFile."zed/tasks.json".text = builtins.toJSON [
    {
      label = "open_alacritty";
      command = ''alacritty --working-directory "$ZED_WORKTREE_ROOT" -e bash -c 'exec tmux new-session -A -s "$(basename "$1")"' _ "$ZED_WORKTREE_ROOT"'';
      reveal = "never";
      hide = "always";
      allow_concurrent_runs = true;
    }
  ];

  programs.zed-editor = {
    enable = true;

    extensions = [
      "catppuccin"

      "nix"
      "lua"
      "python"
      "typescript"
      "java"
      "csharp"
      "sql"
      "go"
      "clojure"
      "basher"
      "dockerfile"
      "markdown"
      "yaml"
      "elm"
      "toml"
      "kdl"
      "ini"
    ];

    extraPackages = with pkgs; [
      # Nix
      nixd
      nil
      nixfmt
      statix
      deadnix

      # Lua
      lua-language-server
      stylua

      # Python
      ruff
      basedpyright

      # TypeScript / JS
      nodejs
      typescript-language-server
      vtsls
      vscode-langservers-extracted
      prettierd

      # Java
      jdt-language-server

      # C# / Unity tooling
      dotnetCorePackages.sdk_8_0
      roslyn-ls
      csharpier

      # SQL
      sqlfluff

      # Go
      gopls
      go
      delve
      golangci-lint

      # Clojure
      clojure-lsp
      clojure
      leiningen

      # Bash
      bash-language-server
      shellcheck
      shfmt

      # Docker
      dockerfile-language-server
      docker-compose-language-service

      # Markdown / YAML
      markdownlint-cli
      yaml-language-server

      # Elm
      elmPackages.elm
      elmPackages.elm-language-server
      elmPackages.elm-format
    ];

    userSettings = {
      buffer_font_family = "Lilex Nerd Font Mono";
      vim_mode = true;
      relative_line_numbers = false;
      autosave = "on_focus_change";

      theme = {
        mode = "dark";
        light = "One Light";
        dark = "Catppuccin Mocha";
      };
      format_on_save = "on";

      project_panel = {
        dock = "left";
      };

      agent = {
        dock = "right";
      };

      # Atlassian's remote MCP server (Jira + Confluence), exposed to the
      # agent panel. Zed handles OAuth itself on first use (browser prompt) -
      # https://support.atlassian.com/atlassian-rovo-mcp-server/docs/setting-up-ides/
      context_servers = {
        atlassian = {
          url = "https://mcp.atlassian.com/v1/mcp/authv2";
        };
      };

      # Zed has built-in edit predictions / Copilot support.
      # Sign in through Zed command palette if needed.
      features = {
        edit_prediction_provider = "copilot";
      };
      lsp = {
        nixd = {
          binary.path = "${pkgs.nixd}/bin/nixd";
        };
        nil = {
          binary.path = "${pkgs.nil}/bin/nil";
        };
        ruff = {
          binary = {
            path = "${pkgs.ruff}/bin/ruff";
            arguments = [ "server" ];
          };
        };
        basedpyright = {
          binary = {
            path = "${pkgs.basedpyright}/bin/basedpyright-langserver";
            arguments = [ "--stdio" ];
          };
        };
        rust-analyzer = {
          binary.path = "${pkgs.rust-analyzer}/bin/rust-analyzer";
        };
        roslyn = {
          binary = {
            path = "${pkgs.roslyn-ls}/bin/Microsoft.CodeAnalysis.LanguageServer";
            arguments = [
              "--stdio"
              "--autoLoadProjects"
            ];
          };
        };
        typescript-language-server = {
          binary = {
            path = "${pkgs.typescript-language-server}/bin/typescript-language-server";
            arguments = [ "--stdio" ];
          };
        };
        vtsls = {
          binary = {
            path = "${pkgs.vtsls}/bin/vtsls";
            arguments = [ "--stdio" ];
          };
        };
        lua-language-server = {
          binary.path = "${pkgs.lua-language-server}/bin/lua-language-server";
        };
        gopls = {
          binary.path = "${pkgs.gopls}/bin/gopls";
        };
        clojure-lsp = {
          binary.path = "${pkgs.clojure-lsp}/bin/clojure-lsp";
        };
        bash-language-server = {
          binary = {
            path = "${pkgs.bash-language-server}/bin/bash-language-server";
            arguments = [ "start" ];
          };
        };
        yaml-language-server = {
          binary = {
            path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
            arguments = [ "--stdio" ];
          };
        };
        elm-language-server = {
          binary = {
            path = "${pkgs.elmPackages.elm-language-server}/bin/elm-language-server";
            arguments = [ "--stdio" ];
          };
        };
      };

      languages = {
        CSharp = {
          language_servers = [ "roslyn" ];
          format_on_save = "on";
          formatter = {
            external = {
              command = "${pkgs.csharpier}/bin/csharpier";
              arguments = [
                "format"
                "--stdin-path"
                "{buffer_path}"
              ];
            };
          };
        };

        Nix = {
          language_servers = [
            "nixd"
            "nil"
          ];
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [ "--quiet" ];
            };
          };
        };

        Python = {
          language_servers = [
            "ruff"
            "basedpyright"
          ];
          formatter = {
            external = {
              command = "${pkgs.ruff}/bin/ruff";
              arguments = [
                "format"
                "--stdin-filename"
                "{buffer_path}"
                "-"
              ];
            };
          };
        };

        TypeScript = {
          language_servers = [
            "typescript-language-server"
            "vtsls"
          ];
          formatter = {
            external = {
              command = "prettierd";
              arguments = [ "{buffer_path}" ];
            };
          };
        };

        JavaScript = {
          language_servers = [ "vtsls" ];
          formatter = {
            external = {
              command = "prettierd";
              arguments = [ "{buffer_path}" ];
            };
          };
        };

        Lua = {
          language_servers = [ "lua-language-server" ];
          formatter = {
            external = {
              command = "stylua";
              arguments = [ "-" ];
            };
          };
        };

        Go = {
          language_servers = [ "gopls" ];
          formatter = {
            external.command = "gofmt";
          };
        };

        "Shell Script" = {
          language_servers = [ "bash-language-server" ];
          formatter = {
            external.command = "shfmt";
          };
        };

        Elm = {
          language_servers = [ "elm-language-server" ];
          formatter = {
            external.command = "elm-format";
            external.arguments = [ "--stdin" ];
          };
        };

        SQL = {
          tab_size = 2;
          formatter = {
            external = {
              command = "${pkgs.sqlfluff}/bin/sqlfluff";
              arguments = [
                "format"
                "--stdin-filename"
                "{buffer_path}"
                "-"
              ];
            };
          };
        };
      };
    };

    userKeymaps = [
      {
        context = "Editor";
        bindings = {
          "ctrl-s" = "editor::Format";
        };
      }
      {
        context = "Editor && vim_mode == normal";
        bindings = {
          "|" = "pane::SplitRight";
          "-" = "pane::SplitDown";

          "shift-h" = "pane::ActivatePrevItem";
          "shift-l" = "pane::ActivateNextItem";
          "space b shift-d" = "pane::CloseOtherItems";
          "space b u" = "pane::ReopenClosedItem";
          "space b b" = "tab_switcher::Toggle";

          "space f f" = "file_finder::Toggle";
          "space f g" = "pane::DeploySearch";

          "space e" = "project_panel::ToggleFocus";
          "space shift-e" = "workspace::ToggleLeftDock";

          "space a" = "agent::ToggleFocus";
          "space shift-a" = "workspace::ToggleRightDock";

          "space w" = "workspace::Save";
          "space q" = "pane::CloseActiveItem";

          "space ctrl-o" = [
            "projects::OpenRecent"
            { create_new_window = false; }
          ];
          "space ctrl-b" = "branches::OpenRecent";

          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-l" = "workspace::ActivatePaneRight";

          "space l g d" = "editor::GoToDefinition";
          "space l g D" = "editor::GoToDeclaration";
          "space l g t" = "editor::GoToTypeDefinition";
          "space l g r" = "editor::FindAllReferences";
          "space l shift-n" = "editor::Rename";
          "space l c a" = "editor::ToggleCodeActions";
          "space l h" = "editor::Hover";

          "space t" = [
            "task::Spawn"
            { task_name = "open_alacritty"; }
          ];
        };
      }
      {
        context = "ProjectPanel";
        bindings = {
          "space e" = "project_panel::ToggleFocus";
          "space shift-e" = "workspace::ToggleLeftDock";
          "ctrl-l" = "project_panel::ToggleFocus";
        };
      }
      {
        context = "AgentPanel && vim_mode == normal";
        bindings = {
          "space a" = "agent::ToggleFocus";
          "space shift-a" = "workspace::ToggleRightDock";
        };
      }
      {
        context = "Editor && vim_mode == insert";
        bindings = {
          # Copilot accept
          "ctrl-l" = "editor::AcceptEditPrediction";
        };
      }
    ];
  };
}
