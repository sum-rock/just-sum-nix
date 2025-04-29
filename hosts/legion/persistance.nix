{ config, lib, ... }:
{
  systemd.services.decrypt-sops = {
    description = "Decrypt sops secrets";
    wantedBy = [ "multi-user.target" ];
    # System SSH is required for decrypting secrets so this bind has to happen first
    after = [ "etc-ssh.mount" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = "2s";
    };
    script = config.system.activationScripts.setupSecrets.text;
  };
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
      "/etc/NetworkManager/system-connections"
      "/etc/ssh" # system ssh required for decrypting secrets with nix sops
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
        ".logseq" # it would be better if this could go in .config
        ".mozilla"
        ".npm"
        ".rustup"
        ".steam"
        ".terminfo"
        "Documents"
        "Downloads"
        "go"
        "Logseq"
        "Books/calibre"
        "Books/koreader"
        "Nextcloud"
        "repositories"
        "Syncthing"
        { directory = ".gnupg"; mode = "0700"; }
      ];
      files = [
        ".ssh/known_hosts"
      ];
    };
  };
}
