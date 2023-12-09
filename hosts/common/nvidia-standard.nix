{ config, pkgs, ... }:
{
  # NVIDIA Drivers
  # --------------
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
    };
    opengl.enable = true;
  };
}
