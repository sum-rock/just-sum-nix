{
  description = "sum-rock's very nice flake";
  
  inputs = {

    # Core inputs 
    # =====================================================
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-22.11";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Extra inputs
    # =====================================================
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

  outputs = { self, darwin, nixpkgs, ... }@attrs: 
  {

    # MacOS Configurations
    # =====================================================
    darwinConfigurations = 
    let 
      mkDarwinWorkstation = name: system: darwin.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules = [
          # Change preferences/default.nix if your not sum-rock
          ./preferences
          ./configurations/macos.nix
          ./homes/macos.nix
        ];
      };
    in
    {
      # Add or change systems here following the pattern below
      #   <hostname> = mkDarwinWorkstation <hostname> <system type>;
      sum-rock-wrk = mkDarwinWorkstation "sum-rock-wrk" "aarch64-darwin";
    };

    # NixOS Configurations
    # =====================================================
    nixosConfigurations =
    let
      mkNixOSWorkstation = name: system: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules = [
          # Change preferences/default.nix if your not sum-rock
          ./preferences
          ./configurations/nixos.nix
          ./homes/nixos.nix
          ./secrets/workstation.nix
          ./hosts/${name}
        ];
      };
    in
    {
      # Add or change systems here following the pattern below
      #   <hostname> = mkNixOSWorkstation <hostname> <system type>;
      xps = mkNixOSWorkstation "xps" "x86_64-linux";
      razer = mkNixOSWorkstation "razer" "x86_64-linux";
    };
  };

}

 


