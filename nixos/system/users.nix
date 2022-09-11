{ config, pkgs, ... }:
{
  users.users.august = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      poetry
    ];
  };
}
