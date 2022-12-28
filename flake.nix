{
  description = "sum-rock's very nice flake";
  
  inputs = {

    # Core systems
    # ------------
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    # Extras
    # ------
    zsh-autocomplete = {
      url = "github:marlonrichert/zsh-autocomplete/main";
      flake = false;
    };
    gruvbox-gtk = {
      url = "github:Fausto-Korpsvart/Gruvbox-GTK-Theme/master";
      flake = false;
    };
    ranger-devicons = {
      url = "github:cdump/ranger-devicons2/master";
      flake = false;
    };
    tmux-plugin-manager = {
      url = "github:tmux-plugins/tpm/master";
      flake = false;
    };
  };

  outputs = { self, darwin, nixpkgs, sops-nix, ... }@attrs: 
  {

    darwinConfigurations = {
      sum-rock-wrk = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = attrs;
        modules = [ 
          ./bundles/workstation_macos.nix 
          ./homes/macos.nix
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
          ./secrets/workstation.nix
          ./homes/nixos.nix
        ];
      };
      razer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./systems/razer
          ./bundles/workstation_nixos.nix
          ./secrets/workstation.nix
          ./homes/nixos.nix
        ];
      };
    };

  };
}

 


