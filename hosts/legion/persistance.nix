{ config, lib, ... }:
{
  environment.persistence."/persistent" = {
    enable = true; # NB: Defaults to true, not needed
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/tailscale"
      "/var/lib/systemd/coredump"
      "/var/keys"
      "/run/secrets.d" # required to prevent loosing sops entries
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      "/root/.config/nix/nix.conf"
    ];
    users.august = {
      directories = [
        ".1password"
        ".cache"
        ".config"
        ".cargo"
        ".local"
        ".mozilla"
        ".npm"
        ".rustup"
        ".steam"
        ".terminfo"
        "Documents"
        "Downloads"
        "go"
        "Logseq"
        "repositories"
        "Syncthing"
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
      ];
    };
  };
}
