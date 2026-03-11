{ ... }:
{
  homebrew = {
    enable = true;

    onActivation = {
      # "zap" removes manually installed brews and casks
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

    brews = [
      "opencode"
    ];

    caskArgs = {
      appdir = "~/Applications";
      no_quarantine = true;
    };

    casks = [
      "dbeaver-community"
      "docker-desktop"
      "aptible"
      "tailscale-app"
      "logseq"
      "android-studio"
      "spotify"
    ];
  };
}
