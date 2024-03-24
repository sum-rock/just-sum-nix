nix-collect-garbage
nix flake lock --update-input sumAstroNvim
nixos-rebuild switch --flake ./#
