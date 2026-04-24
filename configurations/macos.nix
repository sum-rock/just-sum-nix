{ config, pkgs, nixpkgs-unstable, ... }:
let 
  unstable = import nixpkgs-unstable {
    system = "aarch64-darwin";
    config = {};
  }; 
in
{
  imports = [
    ./packages.nix
    ./rebuild
  ];
  #
  # Workaround for aarch64-darwin codesigning bug (nixpkgs#208951 / #507531):
  # fish binaries from the binary cache occasionally have invalid ad-hoc
  # signatures on Apple Silicon. Forcing a local rebuild ensures codesigning
  # is applied on this machine with a valid signature.
  nixpkgs.overlays = [
    (_final: prev: {
      fish = prev.fish.overrideAttrs (_old: {
        # Bust the cache key so fish is always built locally rather than
        # substituted from the binary cache where the signature may be stale.
        NIX_FORCE_LOCAL_REBUILD = "darwin-codesign-fix";
      });
    })
  ];


  nixpkgs.config = { allowUnfree = true; allowBroken = true; };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = 5;
  system.primaryUser = config.primaryUser;

  # Enable both fish and zsh because that's how nix is added to the path
  programs.fish.enable = true;
  programs.zsh.enable = true;

  environment.shells = [pkgs.fish];
  environment.systemPackages = [ unstable.nodejs_24 pkgs.syncthing ];

  users.users.${config.primaryUser} = {
    home = "${config.home-dir-path}";
    shell = pkgs.fish;
  };
}
