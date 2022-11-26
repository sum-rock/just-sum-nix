{ config, pkgs, home-manager, zsh-autocomplete, username, ... }:
{

  # To use this module tmux and exa are required

  environment.systemPackages = with pkgs; [
    alacritty 
    starship 
  ];

  fonts = {
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; })
      font-awesome
    ];
  };

  home-manager.users.${username} = {
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
      "tmux/plugins/tpm".source = pkgs.fetchFromGitHub {
        owner = "tmux-plugins";
        repo = "tpm";
        rev = "master";
        sha256 = "sha256-aGRy5ah1Dxb+94QoIkOy0nKlmAOFq2y5xnf2B852JY0=";
      };
    };
  };
}
