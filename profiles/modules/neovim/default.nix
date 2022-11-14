{ pkgs, config, home-manager, username, ... }:
{
  environment.systemPackages = with pkgs; [
    rnix-lsp
    fd
    nodePackages.coc-pyright
    (
      neovim.override {
        configure = ( import ./customization.nix { pkgs = pkgs; config = config; } );
      }
    )
  ];

  home-manager.users.${username} = {
    xdg.configFile = { 
      "nvim/coc-settings.json".source = ./coc-settings.json;
    };
  };
}
