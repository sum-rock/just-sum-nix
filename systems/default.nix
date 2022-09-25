{ self, nixpkgs, home-manager, nix-darwin, ... }:
let
  mkPkgs = { system, overlays ? [ ] }: import nixpkgs {
    inherit system overlays;
    config.allowUnfree = true;
  };

  nixosSystem = nixpkgs.lib.nixosSystem;
  darwinSystem = nix-darwin.lib.darwinSystem;
  hm-nixos = home-manager.nixosModules.home-manager;
  hm-darwin = home-manager.darwinModules.home-manager;

in
{

  nixosConfigurations = {
    xps = nixosSystem rec {
      pkgs = mkPkgs { inherit system; };
      system = "x86_64-linux";
      modules = [
        hm-nixos
        ./xps
      ]
    };
  };

}

