{ config, lib, ... }:
{
  environment.persistence."/persistent" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/keys"
      "/etc/NetworkManager/system-connections"
      "/root/.config/nix"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
    ];
    users.august = {
      directories = [
        ".1password"
        ".cache"
        ".cargo"
        ".config"
        ".local"
        ".mozilla"
        ".npm"
        ".rustup"
        ".steam"
        ".terminfo"
        ".tmux"
        ".wallpapers"
        "Documents"
        "Downloads"
        "go"
        "Logseq"
        "repositories"
        "Syncthing"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];
      files = [
      ];
    };
  };
}
