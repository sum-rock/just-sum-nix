{ config, pkgs, ... }:
{
  # NVIDIA Drivers
  # --------------
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };
  hardware = {
    opengl = {
      enable = true;
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
