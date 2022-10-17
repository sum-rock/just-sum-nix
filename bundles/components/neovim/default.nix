{ pkgs, config, ... }:

{

  environment.systemPackages = with pkgs; [
    neovim-unwrapped    
    nodejs
    yarn
    rnix-lsp
    nodePackages.coc-pyright
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    configure = ( import ./customization.nix { pkgs = pkgs; config = config; } );
  };

}
