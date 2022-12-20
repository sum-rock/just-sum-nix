{ pkgs, config, home-manager, ... }:
{
  environment.systemPackages = with pkgs; [
    rnix-lsp
    fd
    nodePackages.coc-pyright
    neovide
    (
      neovim.override {
        configure = ( import ./customization.nix { pkgs = pkgs; config = config; } );
      }
    )
  ];

  home-manager.users.${config.primary-user} = {
    xdg.configFile = { 
      "nvim/coc-settings.json".source = ./coc-settings.json;
    };
  };
}
