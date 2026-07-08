{ pkgs, ... }:

{
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
      vscode-langservers-extracted
      prettierd

      # Java
      jdt-language-server

      # SQL
      sqlfluff
      sqls

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
      marksman
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

      # Zed has built-in edit predictions / Copilot support.
      # Sign in through Zed command palette if needed.
      features = {
        edit_prediction_provider = "copilot";
      };
      lsp = {
        nixd = {
          binary.path = "nixd";
        };
        ruff = {
          binary.path = "${pkgs.ruff}/bin/ruff";
        };
        basedpyright = {
          binary = {
            path = "${pkgs.basedpyright}/bin/basedpyright-langserver";
            arguments = [ "--stdio" ];
          };
        };
        rust-analyzer = {
          binary.path = "rust-analyzer";
        };
        typescript-language-server = {
          binary.path = "typescript-language-server";
        };
        gopls = {
          binary.path = "gopls";
        };
        clojure-lsp = {
          binary.path = "clojure-lsp";
        };
        bash-language-server = {
          binary.path = "bash-language-server";
        };
        yaml-language-server = {
          binary.path = "yaml-language-server";
        };
        marksman = {
          binary.path = "marksman";
        };
      };

      languages = {
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
          formatter = {
            external = {
              command = "prettierd";
              arguments = [ "{buffer_path}" ];
            };
          };
        };

        Lua = {
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

        Shell = {
          language_servers = [ "bash-language-server" ];
          formatter = {
            external.command = "shfmt";
          };
        };

        Elm = {
          formatter = {
            external.command = "elm-format";
            external.arguments = [ "--stdin" ];
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
          "space b d" = "pane::CloseActiveItem";
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

          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-j" = "workspace::ActivatePaneDown";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-l" = "workspace::ActivatePaneRight";

          "space l g d" = "editor::GoToDefinition";
          "space l g D" = "editor::GoToDeclaration";
          "space l g t" = "editor::GoToTypeDefinition";
          "space l g r" = "editor::FindAllReferences";
          "space l r n" = "editor::Rename";
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
