{ 
  config, 
  pkgs, 
  home-manager, 
  zsh-autocomplete, 
  ranger-devicons,
  tmux-plugin-manager,
  ... 
}:
let
  # Username for this profile
  username = "august"; 

  module-namespace = {
    pkgs = pkgs;
    config = config;
    home-manager = home-manager;
    zsh-autocomplete = zsh-autocomplete; 
    ranger-devicons = ranger-devicons;
    tmux-plugin-manager = tmux-plugin-manager;
    username = username;
  };
  
  # Loads username and args to these modules
  terminal = ( import ./modules/terminal module-namespace );
  neovim-custom = ( import ./modules/neovim module-namespace  ); 
  ranger-custom = ( import ./modules/ranger module-namespace );

in
{
  imports = [
    home-manager.darwinModule
    terminal
    neovim-custom
    ranger-custom
  ];

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.zsh;
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.${username}= {
    programs.home-manager.enable = true; 
    home.username = "${username}";
    home.homeDirectory = "/Users/${username}";
    home.stateVersion = "22.11";

    programs.zsh = {
      shellAliases = {
        nix-edit = "cd /Users/${username}/.nixpkgs; nvim";
        nix-deploy = "darwin-rebuild switch --flake '/Users/${username}/.nixpkgs' --impure";
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
