{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export _NV_PRIME_RENDER_OFFLOAD=1
    export _NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export _GLX_VENDOR_LIBRARY_NAME=nvidia
    export _VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
  tearPreventionOption = ''
    Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
    Option         "AllowIndirectGLXProtocol" "off"
    Option         "TripleBuffer" "on"
  '';
in
{
  environment.systemPackages = [ nvidia-offload ];
  services.xserver = {
    libinput.enable = true; # for touch pad support
    videoDrivers = [ "nvidia" ];
    screenSection = tearPreventionOption; 
  };
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      prime.offload.enable = true;
      prime.intelBusId = "PCI:00:02:0";
      prime.nvidiaBusId = "PCI:01:00:0";
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
