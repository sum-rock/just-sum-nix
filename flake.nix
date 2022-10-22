{
  description = "sum-rock's very nice flake";
  
  inputs = {
    # Core systems
    # ------------
    nixpkgs = {
      url = "github:nixos/nixpkgs/release-22.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Extras
    # ------
    zsh-autocomplete = {
      url = "github:marlonrichert/zsh-autocomplete/main";
      flake = false;
    };
  };

  outputs = { self, darwin, nixpkgs, ... }@attrs: 
  {

    darwinConfigurations = {
      sum-rock-wrk = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = attrs;
        modules = [ 
          ./bundles/workstation_macos.nix 
          ./profiles/mac.nix
        ];
      };
    };

    nixosConfigurations = {
      xps = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [ 
          ./systems/xps 
          ./bundles/workstation_nixos.nix
          ./profiles/xps.nix
        ];
      };
    };
  };
}

 


