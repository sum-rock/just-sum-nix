{
  description = "sum-rock's very nice flake";

  inputs = {

    # Core inputs 
    # =====================================================
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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
    catppuccin-gtk = {
      url = "github:Fausto-Korpsvart/Catppuccin-GTK-Theme/main";
      flake = false;
    };
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
    tmux-gruvbox = {
      url = "github:egel/tmux-gruvbox/main";
      flake = false;
    };
    tmux-catppuccin = {
      url = "github:catppuccin/tmux";
      flake = false;
    };
    nvim-yanky = {
      url = "github:gbprod/yanky.nvim";
      flake = false;
    };
    nvim-copilot = {
      url = "github:github/copilot.vim/v1.18.0";
      flake = false;
    };
  };

  outputs = { self, darwin, nixpkgs, ... }@attrs:
    {

      # MacOS Configurations
      # =====================================================
      darwinConfigurations =
        let
          mkDarwinWorkstation = name: system: darwin.lib.darwinSystem {
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
          razer = mkNixOSWorkstation "razer" "x86_64-linux";
          the-rig = mkNixOSWorkstation "the-rig" "x86_64-linux";
        };
    };

}

