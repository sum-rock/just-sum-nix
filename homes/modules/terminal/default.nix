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
  tmux = builtins.toFile "tmux.conf" ''
    ${builtins.readFile ./tmux.conf}
    ${tmux-theme}
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

    home.file.".tmux.conf".source = "${tmux}";

    xdg.configFile = {
      "alacritty/alacritty.yml".source = "${alacritty}";
      "tmux/plugins/tpm".source = "${tmux-plugin-manager}";
    };
  };
}
