{ config
, pkgs
, home-manager
, tmux-copycat
, tmux-pain-control
, tmux-sensible
, tmux-open
, tmux-catppuccin
, alacritty-tic
, ...
}:
let
  tmux-conf = builtins.toFile "tmux.conf" ''
    ${builtins.readFile ./tmux.conf}
    ${builtins.readFile "${tmux-catppuccin}/themes/catppuccin_mocha_tmux.conf"}
    run-shell $HOME/.tmux/plugins/tmux-catppuccin/catppuccin.tmux
  '';
in
{
  system.activationScripts.alacritty-tic = {
    text = "${pkgs.ncurses5}/bin/tic -o${config.home-dir-path}/.terminfo -x ${alacritty-tic}/extra/alacritty.info";
  };
  environment.systemPackages = [
    pkgs.tmux
    pkgs.eza
    pkgs.starship
  ];

  home-manager.users.${config.primary-user} = {
    programs.fish = {
      enable = true;
      shellAliases = {
        ls = "ls -la";
        lsx = "exa --long --all --header --group --git --icons --time-style=long-iso";
      };
      interactiveShellInit = ''
        direnv hook fish | source
        export DIRENV_LOG_FORMAT=""
        
        starship init fish | source 
      '';
    };
    xdg.configFile = {
      "alacritty/alacritty.toml".source = ./alacritty.toml;
    };
    home.file = {
      ".tmux.conf".source = "${tmux-conf}";
      ".tmux/plugins/tmux-copycat" = {
        source = "${tmux-copycat}";
        recursive = true;
      };
      ".tmux/plugins/tmux-pain-control" = {
        source = "${tmux-pain-control}";
        recursive = true;
      };
      ".tmux/plugins/tmux-sensible" = {
        source = "${tmux-sensible}";
        recursive = true;
      };
      ".tmux/plugins/tmux-open" = {
        source = "${tmux-open}";
        recursive = true;
      };
      ".tmux/plugins/tmux-catppuccin" = {
        source = "${tmux-catppuccin}";
        recursive = true;
      };
    };
  };
}
