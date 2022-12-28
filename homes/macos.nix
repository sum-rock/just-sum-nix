{ config, pkgs, home-manager, ... }:
{
  imports = [
    home-manager.darwinModule
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

  home-manager.users.${config.primary-user}= {
    programs.home-manager.enable = true; 
    home.username = "${config.primary-user}";
    home.homeDirectory = "${config.home-dir-path}";
    home.stateVersion = "22.11";

    programs.zsh = {
      shellAliases = {
        nix-edit = "cd ${config.home-dir-path}/.nixpkgs; nvim .";
        nix-deploy = "darwin-rebuild switch --flake github:sum-rock/just-sum-nix/master";
        nix-test = "darwin-rebuild switch --flake ${config.home-dir-path}/.nixpkgs";
        go-homebase = "cd ~/repositories/pyhomebase";
        go-notes = "cd ~/Documents/notes";
        notes = "cd ~/Documents/notes; nvim .";
        staging-db = "aptible db:tunnel homebase-two-staging --port 52210";
        production-db = "aptible db:tunnel homebase-two-prod --port 54171";
        git-wipit = "git add .; git commit -m wip --no-verify";
        git-pull-develop = "git checkout develop; git pull; git checkout -";
        hb-docker-up = "docker-compose -f ~/repositories/pyhomebase/docker-compose.yml up -d redis rabbitmq db";
        postgres-docker-up = "docker run -d -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 --name test-postgres postgres";
      };
      initExtra = ''
        VSCODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin" 
        AFFECT_TOOLS="$HOME/repositories/affect-tools/tools/bin"  
        if [ -d $VSCODE ] ; then export PATH="$VSCODE:$PATH" ; fi
        if [ -d "$HOME/go/bin" ]; then export PATH="$HOME/go/bin:$PATH" ; fi 
        if [ -d $AFFECT_TOOLS ]; then export PATH="$AFFECT_TOOLS:$PATH" ; fi
        if [ -d "$HOME/.cargo" ]; then export PATH="$HOME/.cargo/bin:$PATH" ; fi 

        . $HOME/.asdf/asdf.sh 
        export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
      '';
    };
  };
}
