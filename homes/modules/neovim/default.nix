{ pkgs, config, nvim-yanky, nvim-copilot, ... }:
let
  # Plugin theme
  # =======================================================
  plugin-themes = {
    gruvbox = [ pkgs.vimPlugins.gruvbox-flat-nvim ];
    catppuccin = [ pkgs.vimPlugins.catppuccin-nvim ];
  };
  plugin-theme = plugin-themes.${config.theme};

  # Init theme
  # =======================================================
  init-themes = {
    gruvbox = builtins.readFile ./themes/gruvbox.lua;
    catppuccin = builtins.readFile ./themes/catppuccin.lua;
  };
  init-theme = init-themes.${config.theme};
  init-lua = builtins.toFile "init.lua" ''
    ${init-theme}
    ${builtins.readFile ./init.lua}
  '';

  # Derivations
  # =======================================================
  yanky = pkgs.vimUtils.buildVimPlugin {
    pname = "yanky-nvim";
    version = "1.0";
    src = nvim-yanky;
  };
  # Must initialize with :Copilot setup
  copilot = pkgs.vimUtils.buildVimPlugin {
    pname = "copilot-vim";
    version = "1.0";
    src = nvim-copilot;
  };
in
{
  environment.systemPackages = with pkgs; [
    rnix-lsp
    fd
    nodePackages.coc-pyright
    luajitPackages.lua-lsp
  ];
  home-manager.users.${config.primary-user} = {
    xdg.configFile = {
      "nvim/coc-settings.json".source = ./coc-settings.json;
    };
    xdg.configFile = {
      "nvim/lua".source = ./lua;
    };
    xdg.configFile = {
      "nvim/init.lua".source = "${init-lua}";
    };
    programs.zsh = {
      sessionVariables = {
        EDITOR = "nvim";
        OPENAI_API_KEY = "$(cat ${config.home-dir-path}/.openai)";
        OPENAI_API_HOST = "https://api.openai.com";
      };
    };
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [
        lualine-nvim
        nvim-web-devicons
        (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
        nvim-tree-lua
        vim-devicons
        vim-nix
        vim-startify
        neoscroll-nvim
        telescope-nvim
        git-blame-nvim
        diffview-nvim
        lazygit-nvim
        bufferline-nvim
        vim-gitgutter
        toggleterm-nvim
        terminus # Helps integrate into terminal required for gitgutter
        vim-polyglot
        hop-nvim
        nvim-autopairs
        nvim-ts-autotag
        which-key-nvim
        coc-nvim
        coc-sqlfluff
        coc-spell-checker
        coc-pyright
        coc-html
        coc-tsserver
        coc-json
        coc-prettier
        coc-go
        yanky
        copilot
      ] ++ plugin-theme;
    };
  };
}
