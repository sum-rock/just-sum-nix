{ pkgs, config, ... }:

let
  options = builtins.readFile ./options.vim;
  plugins = builtins.readFile ./plugins.vim;
in

{
  customRC = ''
    ${options} 
    ${plugins}
  '';
  packages.neovimPlugins = with pkgs.vimPlugins; {
    start = [
      gruvbox-flat-nvim
      lualine-nvim 
      nvim-web-devicons
      nvim-treesitter
      nerdtree
      vim-devicons
      vim-nerdtree-syntax-highlight
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
      coc-nvim
      coc-pyright
      coc-html
      coc-tsserver
      coc-json
   ];
  };
}
