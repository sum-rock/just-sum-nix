{ config, pkgs, ... }:
{
  config = {
    sops.age.keyFile = "${config.home-dir-path}/.config/sops/age/keys.txt";
    sops.defaultSopsFile = ./secrets.yaml;
    sops.secrets.github_creds = { 
      owner = "${config.primary-user}";
      path = "${config.home-dir-path}/.git-credentials";
    };
  };
}
