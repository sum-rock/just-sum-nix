{
  description = "sum-rock's very nice flake";

  inputs = {

    # Core inputs 
    # =====================================================
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.05";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sum-astro-nvim = {
      url = "github:sum-rock/SumAstroNvim/master";
      inputs.nixpkgs.follows = "darwin";
    };
    private = {
      url = "github:sum-rock/nixos-private/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    nix-impermanence = {
      url = "github:nix-community/impermanence/master";
    };

    # Extra inputs
    # =====================================================

    ranger-devicons = {
      url = "github:cdump/ranger-devicons2/master";
      flake = false;
    };
    tmux-copycat = {
      url = "github:tmux-plugins/tmux-copycat/master";
      flake = false;
    };
    tmux-pain-control = {
      url = "github:tmux-plugins/tmux-pain-control/master";
      flake = false;
    };
    tmux-sensible = {
      url = "github:tmux-plugins/tmux-sensible/master";
      flake = false;
    };
    tmux-open = {
      url = "github:tmux-plugins/tmux-open/master";
      flake = false;
    };
    tmux-catppuccin = {
      url = "github:catppuccin/tmux";
      flake = false;
    };
    alacritty-tic = {
      url = "github:alacritty/alacritty/master";
      flake = false;
      # url = "https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info";
    };
  };

  outputs =
    { self
    , darwin
    , nixpkgs
    , nixpkgs-unstable
    , nixos-hardware
    , private
    , sum-astro-nvim
    , nix-impermanence
    , ...
    }@attrs:
    {

      # MacOS Configurations
      # =====================================================
      darwinConfigurations =
        let
          mkDarwinWorkstation = name: system: darwin.lib.darwinSystem {
            inherit system;
            specialArgs = attrs;
            modules = [
              # Change preferences/default.nix if you're not sum-rock
              ./preferences
              ./configurations/macos.nix
              ./homes/macos.nix
              sum-astro-nvim.darwinModules.astroNvim
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
              ./hosts/${name}
              sum-astro-nvim.nixosModules.astroNvim
              # Remove these modules if you're not sum-rock
              private.nixosModules.syncthing
              private.nixosModules.secrets
            ];
          };
        in
        {
          # Add or change systems here following the pattern below
          #   <hostname> = mkNixOSWorkstation <hostname> <system type>;
          razer = mkNixOSWorkstation "razer" "x86_64-linux";
          the-rig = mkNixOSWorkstation "the-rig" "x86_64-linux";
          legion = mkNixOSWorkstation "legion" "x86_64-linux";
        };
    };
}
