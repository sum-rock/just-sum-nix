{ config, pkgs, ... }:
{
  config = {
    sops.age.keyFile = "${config.home-dir-path}/.config/sops/age/keys.txt";
    sops.defaultSopsFile = ./secrets.yaml;
    sops.secrets.example_key = {};
  };
}
