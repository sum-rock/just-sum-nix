{ pkgs, config, ... }:
{
   customRC = pkgs.callPackage ./vimrc.nix {};
   packages.neovimPlugins = with pkgs.vimPlugins; {
     start = [
       vim-airline
       vim-airline-themes
       nvim-treesitter
       nvim-tree-lua
       vim-nix 
     ];
   };
}
