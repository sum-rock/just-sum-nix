{ config, pkgs, ... }:
{
  # NVIDIA Drivers
  # --------------
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  services.xserver = {
    videoDrivers = [ "nvidia" ];
  };
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      # NOTE: Extra packages here for video acceleration 
      extraPackages = with pkgs; [ libva vaapiVdpau libvdpau-va-gl ];
    };
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
