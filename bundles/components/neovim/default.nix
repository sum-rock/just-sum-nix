{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
    rnix-lsp
    nodePackages.coc-pyright
    (
      neovim.override {
        configure = ( import ./customization.nix { pkgs = pkgs; config = config; } );
      }
    )
  ];
}
