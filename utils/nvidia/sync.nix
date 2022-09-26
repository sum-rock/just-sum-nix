{ config, pkgs, ... }:
{
  services.xserver = {
    libinput.enable = true; # for touch pad support
    videoDrivers = [ "nvidia" ];
  };
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      prime = {
        sync.enable = true;
        intelBusId = "PCI:00:02:0";
        nvidiaBusId = "PCI:01:00:0";
      };
    };
    opengl = {
      enable = true;
      extraPackages = [
        pkgs.mesa.drivers
        pkgs.linuxPackages.nvidia_x11.out
      ];
    };
  };
}
