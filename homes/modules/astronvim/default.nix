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
      "nvim/init.lua" = {
        source = "${astronvim}/init.lua";
      };
      "nvim/lua/astronvim" = {
        source = "${astronvim}/lua/astronvim";
        recursive = true;
      };
      "nvim/lua/plugins" = {
        source = "${astronvim}/lua/plugins";
        recursive = true;
      };
      "nvim/lua/resession" = {
        source = "${astronvim}/lua/resession";
        recursive = true;
      };
      "nvim/lua/lazy_snapshot.lua" = {
        source = "${astronvim}/lua/lazy_snapshot.lua";
      };
      "nvim/lua/user" = {
        source = ./user;
      };
    };
  };
}
