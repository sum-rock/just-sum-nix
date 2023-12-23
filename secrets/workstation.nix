{ config, pkgs, sops-nix, ... }:
{
  imports = [ sops-nix.nixosModules.sops ];

  config = {
    sops.age.keyFile = "${config.home-dir-path}/.config/sops/age/keys.txt";
    sops.defaultSopsFile = ./secrets.yaml;
    sops.secrets = {
      "workstation/tokens/openai" = { 
        owner = "${config.primary-user}";
        mode = "0666";
        path = "${config.home-dir-path}/.openai";
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
      "workstation/ssh/git_pvt" = {
        owner = "${config.primary-user}";
        mode = "0600";
        path = "${config.home-dir-path}/.ssh/github_rsa";
      };
      "workstation/ssh/git_pub" = {
        owner = "${config.primary-user}";
        mode = "0644";
        path = "${config.home-dir-path}/.ssh/github_rsa.pub";
      };
      "workstation/config/git" = {
        owner = "${config.primary-user}";
        mode = "0644";
        path = "${config.home-dir-path}/.gitconfig";
      };
      "workstation/config/ssh" = {
        owner = "${config.primary-user}";
        mode = "0644";
        path = "${config.home-dir-path}/.ssh/config";
      };
    };
  };
}
