# Impermanence
#
# The Btrfs "root" subvolume is deleted and recreated on every boot,
# giving the system a fresh / each time. Any state not explicitly
# persisted is lost after reboot.
#
# Paths listed below are bind-mounted from the "persistent" subvolume,
# allowing them to survive root resets. Add new application state here
# if it should be retained across reboots.
#
# Rule of thumb:
#   - Not listed here -> ephemeral, wiped on reboot
#   - Listed here     -> persistent, survives reboot
#
# Important examples:
#   - /etc/ssh is persisted so host keys remain stable
#   - sops-nix relies on those stable SSH keys for decryption
#   - /nix and /persistent are separate Btrfs subvolumes and are not wiped

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
  boot.initrd.systemd.services.rollback-root = {
    description = "Rollback Btrfs root subvolume";

    requiredBy = [ "initrd.target" ];
    before = [ "sysroot.mount" ];

    # Run after LUKS devices are opened, but before /sysroot is mounted.
    after = [
      "systemd-cryptsetup@enc0.service"
      "systemd-cryptsetup@enc1.service"
    ];

    unitConfig.DefaultDependencies = false;
    serviceConfig.Type = "oneshot";

    script = ''
      mkdir -p /mnt
      mount -t btrfs /dev/disk/by-uuid/96072d29-ef1f-45dd-b82e-680675a3a1f1 /mnt

      delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
          delete_subvolume_recursively "/mnt/$i"
        done
        btrfs subvolume delete "$1"
      }

      delete_subvolume_recursively /mnt/root
      btrfs subvolume create /mnt/root

      umount /mnt
    '';
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
