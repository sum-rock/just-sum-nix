{ config, pkgs, ... }:
{
  system.activationScripts.syncthingFolders= ''
    mkdir -p /home/${config.primary-user}/Syncthing
    mkdir -p /home/${config.primary-user}/Logseq
    chown ${config.primary-user}:users /home/${config.primary-user}/Syncthing
    chown ${config.primary-user}:users /home/${config.primary-user}/Logseq
  '';
  services.syncthing = {
    enable = true;
    user = "${config.primary-user}";
    dataDir = "/home/${config.primary-user}/Syncthing";
    overrideDevices = true;
    settings = {
      devices = {
        "vera" = {
          id = "V76GRJ3-PDIPF37-JNU3UMA-CHD75HU-5YVZYNQ-CDTMBUY-4BDAHIA-3PHBAAT";
          addresses = [ "tcp://100.69.99.101:22000" ];
        };
      };
      folders = {
        "/home/${config.primary-user}/Logseq" = {
          label = "Logseq";
          id = "6dkcu-reowp";
          devices = [ "vera" ];
        };
      };
    };
  };
}
