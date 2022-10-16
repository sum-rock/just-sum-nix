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

  outputs = { self, darwin, nixpkgs, ... }@attrs: 
  {
    darwinConfigurations."raack-wrk" = {
      system = "aarch64-darwin";
      modules = [ ./bundles/macos.nix ];
    };
    nixosConfigurations.xps = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ 
        ./systems/xps 
        ./bundles/workstation.nix
        ./desktops/i3wm
      ];
    };
  };
}

 
