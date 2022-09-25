{ pkgs, config, ... }:

{

  environment.systemPackages = with pkgs; [
    neovim-unwrapped    
    nodejs
    yarn
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    configure = ( import ./customization.nix { pkgs = pkgs; config = config; } );
  };
}
