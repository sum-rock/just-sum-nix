{ config, pkgs, home-manager, zsh-autocomplete, tmux-plugin-manager, ... }:
let 
  tmux-open = pkgs.writeShellScriptBin "tmux-open" ''
    if [[ -z $(tmux ls | grep $1) ]]; then
      tmux new -s $1
    else
      tmux attach -t $1
    fi
  '';

  # Alacritty Config
  # =======================================================
  alacritty-themes = {
    gruvbox = builtins.readFile ./themes/gruvbox-flat.yml;
    catppuccin = builtins.readFile ./themes/catppuccin-frappe.yml;
  };
  alacritty-theme = alacritty-themes.${config.theme};
  alacritty = builtins.toFile "alacritty.yml" ''
    ${builtins.readFile ./alacritty.yml}
    ${alacritty-theme}
  '';

  # Tmux Config
  # =======================================================
  tmux-themes = {
    gruvbox = ''
      set -g @plugin 'egel/tmux-gruvbox'
      set -g @tmux-gruvbox 'dark'
    '';
    catppuccin = ''
      set -g @plugin 'catppuccin/tmux' 
      set -g @catppuccin_flavour 'frappe'
    '';
  };
  tmux-theme = tmux-themes.${config.theme};
  tmux-conf = builtins.toFile "tmux.conf" ''
    ${builtins.readFile ./tmux.conf}
    ${tmux-theme}
  '';
  
  # Tmux Color Correction
  # =======================================================
  # https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
  tmux-init = pkgs.writeShellScriptBin "tmux-init" ''
    CONF="$HOME/.tmux/setup"
    tic -x $CONF/xterm-256color-italic.terminfo
    tic -x $CONF/tmux-256color.terminfo
  '';
  xterm-italic = builtins.toFile "xterm-256color-italic.terminfo" ''
    xterm-256color-italic|xterm with 256 colors and italic,
      sitm=\E[3m, ritm=\E[23m,
      use=xterm-256color,
  '';
  tmux-color = builtins.toFile "tmux-256color.terminfo" ''
    tmux-256color|tmux with 256 colors,
      ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,
      khome=\E[1~, kend=\E[4~,
      use=xterm-256color, use=screen-256color,
  '';

in
{
  environment.systemPackages = [
    pkgs.tmux
    pkgs.exa
    pkgs.alacritty 
    pkgs.starship 
    tmux-open
    tmux-init
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
    home.file ={
      ".tmux/setup/xterm-256color-italic.terminfo".source = "${xterm-italic}";
      ".tmux/setup/tmux-256color.terminfo".source = "${tmux-color}";
      ".tmux.conf".source = "${tmux-conf}";
    };
    xdg.configFile = {
      "alacritty/alacritty.yml".source = "${alacritty}";
      "tmux/plugins/tpm".source = "${tmux-plugin-manager}";
    };
  };
}
