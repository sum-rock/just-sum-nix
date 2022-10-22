{ pkgs, config, home-manager, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs
    yarn
    npm
    rnix-lsp
    nodePackages.coc-pyright
    (
      neovim.override {
        configure = ( import ./customization.nix { pkgs = pkgs; config = config; } );
      }
    )
  ];

  home-manager.users.${user} = {
    xdg.configFile = { 
      "nvim/coc-settings.json".source = ./coc-settings.json;
    };
  };
}
