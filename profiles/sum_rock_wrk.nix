{ config, pkgs, zsh-autocomplete, ... }:

{

  users.users.august = {
    home = "/Users/august";
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.august = {
    programs.home-manager.enable = true; 
    home.username = "august";
    home.homeDirectory = "/Users/august";

    programs.zsh = {
      enable = true;
      plugins = [
        { name = "zsh-autocomplete"; src = zsh-autocomplete; }
      ];
      shellAliases = {
        ls = "ls -la";
        rf = "source ~/.zshrc";
        lsx = "exa --long --all --header --group --git --icons --time-style=long-iso"; 
        nix-edit = "cd /Users/august/.nixpkgs; nvim";
        nix-deploy = "darwin-rebuild switch --flake '/Users/august/.nixpkgs' --impure";
        go-homebase = "cd ~/repositories/pyhomebase";
        go-notes = "cd ~/Documents/notes";
        notes = "cd ~/Documents/notes; nvim";
        staging-db = "aptible db:tunnel homebase-two-staging --port 52210";
        production-db = "aptible db:tunnel homebase-two-prod --port 54171";
        git-wipit = "git add .; git commit -m wip --no-verify";
        git-pull-develop = "git checkout develop; git pull; git checkout -";
        hb-docker-up = "docker-compose -f ~/repositories/pyhomebase/docker-compose.yml up -d redis rabbitmq db";
        postgres-docker-up = "docker run -d -e POSTGRES_HOST_AUTH_METHOD=trust -p 5432:5432 --name test-postgres postgres";
        show-utc = "TZ=UTC tock -cms";
        show-est = "TZ=America/New_York tock -cms";
        show-cst = "TZ=America/Chicago tock -cms";
      };
      initExtra = ''

eval "$(starship init zsh)"
# zstyle ':autocomplete:*' list-lines 8
# zstyle ':autocomplete:*' min-delay 1.02 
# zstyle ':autocomplete:history-search:*' list-lines 8 

VSCODE="/Applications/Visual Studio Code.app/Contents/Resources/app/bin" 
AFFECT_TOOLS="$HOME/repositories/affect-tools/tools/bin"  
if [ -d "$HOME/.poetry" ] ; then export PATH="$HOME/.poetry/bin:$PATH" ; fi
if [ -d $VSCODE ] ; then export PATH="$VSCODE:$PATH" ; fi
if [ -d "$HOME/go/bin" ]; then export PATH="$HOME/go/bin:$PATH" ; fi 
if [ -d $AFFECT_TOOLS ]; then export PATH="$AFFECT_TOOLS:$PATH" ; fi
if [ -d "$HOME/.cargo" ]; then export PATH="$HOME/.cargo/bin:$PATH" ; fi 

. $HOME/.asdf/asdf.sh 
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
  
      '';
    };

    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./dotfiles/alacritty/alacritty.yml;
      "nvim/coc-settings.json".source = ./dotfiles/nvim/coc-settings.json;
    };

  };
}
