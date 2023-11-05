{ config, pkgs, sops-nix, ... }:
{
  imports = [ sops-nix.nixosModules.sops ];

  config = {
    sops.age.keyFile = "${config.home-dir-path}/.config/sops/age/keys.txt";
    sops.defaultSopsFile = ./secrets.yaml;
    sops.secrets = {
      "workstation/github/credentials" = { 
        owner = "${config.primary-user}";
        mode = "0600";
        path = "${config.home-dir-path}/.git-credentials";
      };
      "workstation/ssh/pvt" = {
        owner = "${config.primary-user}";
        mode = "0600";
        path = "${config.home-dir-path}/.ssh/id_rsa";
      };
      "workstation/ssh/pub" = {
        owner = "${config.primary-user}";
        mode = "0644";
        path = "${config.home-dir-path}/.ssh/id_rsa.pub";
      };
    };
  };
}
