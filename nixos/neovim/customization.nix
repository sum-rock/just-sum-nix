{ pkgs, config, ... }:
{
   customRC = pkgs.callPackage ./vimrc.nix {};
   packages.neovimPlugins = with pkgs.vimPlugins; {
     start = [
       pkgs.vimPlugins.vim-airline
       gruvbox
     ];
   };
}
