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
    };

    casks = [
      "dbeaver-community"
      "docker-desktop"
      "aptible"
      "tailscale-app"
      "android-studio"
      "spotify"
      "macshot"
    ];
  };
}
