{ config, pkgs, ... }:
{
  config = {
    sops.age.keyFile = "/home/${config.primary-user}/.config/sops/age/keys.txt";
    sops.defaultSopsFile = ./secrets.yaml;
    sops.secrets.example_key = {};
  };
}
