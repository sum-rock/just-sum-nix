{ pkgs, config, ... }:
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
      "nvim/init.lua".source = ./init.lua;
    };
    programs.neovim = {
      enable = true;
      plugins = with pkgs.vimPlugins; [ 
        gruvbox-flat-nvim
        lualine-nvim 
        nvim-web-devicons
        (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
        nvim-tree-lua
        vim-devicons
        vim-nix 
        vim-startify
        neoscroll-nvim
        telescope-nvim
        minimap-vim
        git-blame-nvim
        diffview-nvim
        bufferline-nvim
        vim-gitgutter
        toggleterm-nvim
        terminus       # Helps integrate into terminal required for gitgutter
        vim-polyglot
        glow-nvim
        hop-nvim
        coc-nvim
        coc-pyright
        coc-html
        coc-tsserver
        coc-json
     ];
   };
 };
}
