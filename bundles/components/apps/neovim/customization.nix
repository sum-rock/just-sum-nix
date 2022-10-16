{ pkgs, config, ... }:
{
  customRC = pkgs.callPackage ./vimrc.nix {};
  packages.neovimPlugins = with pkgs.vimPlugins; {
   start = [
     gruvbox-nvim
     vim-airline
     vim-airline-themes
     nvim-treesitter
     nerdtree
     vim-devicons
     vim-nerdtree-syntax-highlight
     vim-nix 
     vim-startify
     neoscroll-nvim
     telescope-nvim
     minimap-vim
     bufferline-nvim
     vim-fugitive
     coc-nvim
     coc-pyright
     coc-html
     coc-tsserver
     coc-json
   ];
  };
}
