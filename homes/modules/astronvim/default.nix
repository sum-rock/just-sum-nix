{ pkgs, config, astronvim, ... }:
{
  environment.systemPackages = with pkgs; [
    rustup # Must run `rustup default stable`
    ripgrep
    gdu
    bottom
    nodejs_20
    neovim
  ];
  home-manager.users.${config.primary-user} = {
    xdg.configFile = {
      "nvim/" = {
        source = "${astronvim}";
        recursive = true;
      };
    };
  };
}
