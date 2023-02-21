{ config, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  environment.systemPackages = [ nvidia-offload ];
  services.xserver = {
    libinput.enable = true; # for touch pad support
    videoDrivers = [ "nvidia" ];
  };
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      prime = {
        offload.enable = true;
        # sync.enable = true;
        intelBusId = "PCI:00:02:0";   # TODO: These need to be options set at the hosts/$HOST/default.nix level
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
