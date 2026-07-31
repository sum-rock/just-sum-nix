{
  config,
  lib,
  pkgs,
  nixos-hardware,
  nix-impermanence,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./persistance.nix
    ./subvol_delete
    nixos-hardware.nixosModules.lenovo-legion-16irx9h
    nix-impermanence.nixosModules.impermanence
  ];

  # This solves issues related to waking from sleep.
  hardware.nvidia.powerManagement.enable = false;

  # Limit NVIDIA's per-process free-buffer pool when Niri renders on the dGPU.
  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text =
    builtins.toJSON {
      rules = [
        {
          pattern = {
            feature = "procname";
            matches = "niri";
          };
          profile = "Limit Free Buffer Pool On Wayland Compositors";
        }
      ];
      profiles = [
        {
          name = "Limit Free Buffer Pool On Wayland Compositors";
          settings = [
            {
              key = "GLVidHeapReuseRatio";
              value = 0;
            }
          ];
        }
      ];
    };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "legion";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  system.stateVersion = "24.05"; # Did you read the comment?

  environment.systemPackages = with pkgs; [
    lenovo-legion
    input-remapper
  ];

  users.users.${config.primaryUser} = {
    hashedPassword = "$y$j9T$zIhzVDjq/JpRoqrmwCSG4/$xoRiXmuuhAKIls/QpjbWRAqPiG48BuSE.HhpacwWSq/";
  };
}
