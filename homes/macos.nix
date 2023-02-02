{ config, pkgs, home-manager, gruvbox-gtk, ... }:
{
  imports = [
    home-manager.darwinModule
    ./modules/yabai
    ./modules/terminal
    ./modules/neovim
    ./modules/ranger
  ];

  primary-user = "august";
  home-dir-path = "/Users/august";

  users.users.${config.primary-user} = {
    home = "${config.home-dir-path}";
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${config.primary-user} = {
    programs.home-manager.enable = true;
    home.username = "${config.primary-user}";
    home.homeDirectory = "${config.home-dir-path}";
    home.stateVersion = "22.11";
    home.file = {
      ".wallpapers/gruvbox10.png" = {
        source = ./wallpapers/gruvbox10.png;
      };
      ".wallpapers/gruvbox16.png" = {
        source = ./wallpapers/gruvbox16.png;
      };
      ".wallpapers/gruvbox18.png" = {
        source = ./wallpapers/gruvbox18.png;
      };
    };
    programs.zsh = {
      shellAliases = {
        yabai-rf = "launchctl kickstart -k \"gui/$UID/org.nixos.yabai\"; skhd --reload";
        nix-edit = "cd ${config.home-dir-path}/.nixpkgs; nvim .";
        nixos-rebuild-flake = "darwin-rebuild switch --flake ${config.home-dir-path}/.nixpkgs";
        go-homebase = "cd ~/repositories/pyhomebase";
        go-notes = "cd ~/Documents/notes";
        notes = "cd ~/Documents/notes; nvim .";
        staging-db = "aptible db:tunnel homebase-two-staging --port 52210";
        production-db = "aptible db:tunnel homebase-two-prod --port 54171";
        git-wipit = "git add .; git commit -m wip --no-verify";
        git-pull-develop = "git checkout develop; git pull; git checkout -";
        postgres-docker-up = "docker run -d -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 --name test-postgres postgres";
      };
      initExtra = ''
        VSCODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin" 
        if [ -d $VSCODE ] ; then export PATH="$VSCODE:$PATH" ; fi

        export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
        export DIRENV_LOG_FORMAT=""
      '';
    };
  };
}
