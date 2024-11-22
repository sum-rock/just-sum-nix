# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "thunderbolt" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ lenovo-legion-module ];
  boot.supportedFilesystems = [ "btrfs" ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/96072d29-ef1f-45dd-b82e-680675a3a1f1";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  boot.initrd.luks.devices."enc0".device = "/dev/disk/by-uuid/20a0eb41-68e0-453d-9605-2c6834d96e88";
  boot.initrd.luks.devices."enc1".device = "/dev/disk/by-uuid/095e8ff2-f20c-4331-9c5d-e240123dbce8";

  fileSystems."/nix" =
    {
      device = "/dev/disk/by-uuid/96072d29-ef1f-45dd-b82e-680675a3a1f1";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/persistent" =
    {
      device = "/dev/disk/by-uuid/96072d29-ef1f-45dd-b82e-680675a3a1f1";
      fsType = "btrfs";
      options = [ "subvol=persistent" "compress=zstd" "noatime" ];
      neededForBoot = true;
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/F327-6822";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/7c7bccde-a2b0-48ab-8a2a-59c3ba45b826"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp114s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
