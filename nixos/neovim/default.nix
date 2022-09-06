{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    configure = ( import ./customization.nix { pkgs = pkgs; config = config; } );
  };

  environment = {
    systemPackages = with pkgs; [
      rnix-lsp
    ];
  };
}
