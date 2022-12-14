{ config, pkgs, home-manager, zsh-autocomplete, tmux-plugin-manager, ... }:
let 
  tmux-open = pkgs.writeShellScriptBin "tmux-open" ''
    if [[ -z $(tmux ls | grep $1) ]]; then
      tmux new -s $1
    else
      tmux attach -t $1
    fi
  '';
in
{
  # To use this module tmux and exa are required
  environment.systemPackages = [
    pkgs.alacritty 
    pkgs.starship 
    tmux-open
  ];

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      font-awesome
    ];
  };

  home-manager.users.${config.primary-user} = {
    programs.zsh = {
      enable = true;
      plugins = [
        { name = "zsh-autocomplete"; src = zsh-autocomplete; }
      ];
      shellAliases = {
        ls = "ls -la";
        rf = "source ~/.zshrc";
        lsx = "exa --long --all --header --group --git --icons --time-style=long-iso"; 
      };
      initExtraBeforeCompInit = ''
        eval "$(starship init zsh)"
        # zstyle ':autocomplete:*' list-lines 8
        # zstyle ':autocomplete:*' min-delay 1.02 
        # zstyle ':autocomplete:history-search:*' list-lines 8 
      '';
    };

    home.file.".tmux.conf".source = ./tmux.conf;

    xdg.configFile = {
      "alacritty/alacritty.yml".source = ./alacritty.yml;
      "tmux/plugins/tpm".source = "${tmux-plugin-manager}";
    };
  };
}
