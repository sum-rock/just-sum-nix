{
  description = "sum-rock's very nice flake";
  
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, darwin, nixpkgs, home-manager, ... }:   
  {

    homeConfigurations = {      
      sum-rock-wrk = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.aarch64-darwin;
        modules = [ ./profiles/sum-rock-wrk.nix ];
        extraSpecialArgs = { 
          pkgsUnstable = inputs.nixpkgsUnstable.legacyPackages.aarch64-darwin; 
        };
      };
    };

    darwinConfigurations = {
      # nix build .#darwinConfigurations.sum-rock-wrk.system \
      # ./result/sw/bin/darwin-rebuild switch --flake .
      sum-rock-wrk = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./bundles/macos.nix ];
        inputs = { inherit darwin nixpkgs; };
      };
    };

    nixosConfigurations = {
      xps = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { common = self.common; inherit inputs; };
        modules = [ 
          ./systems/xps 
          ./bundles/workstation.nix
          ./desktops/i3wm
        ];
      };
    };
  };
}

 
