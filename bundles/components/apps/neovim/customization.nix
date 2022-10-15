{ pkgs, config, ... }:
{
  customRC = pkgs.callPackage ./vimrc.nix {};
  packages.neovimPlugins = with pkgs.vimPlugins; {
   start = [
     gruvbox-community
     vim-airline
     vim-airline-themes
     nvim-treesitter
     nerdtree
     vim-devicons
     vim-nerdtree-syntax-highlight
     vim-nix 
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
