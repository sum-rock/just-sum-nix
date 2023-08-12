{ pkgs, config, nvim-yanky, nvim-chatgpt, ... }:
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
  yanky = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "yanky-nvim";
    version = "1.0";
    src = nvim-yanky;
  };
  chatgpt = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "chatgpt-nvim";
    version = "1.0";
    src = nvim-chatgpt;
  };
in
{
  environment.systemPackages = with pkgs; [
    rnix-lsp
    fd
    nodePackages.coc-pyright
    luajitPackages.lua-lsp
    neovide
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
        OPENAI_API_HOST = "api.openai.com";
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
        glow-nvim
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
        yanky
        chatgpt
        plenary-nvim # Required for chatgpt
        nui-nvim # Required for chatgpt
      ] ++ plugin-theme;
    };
  };
}
