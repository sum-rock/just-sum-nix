# Just Sum Nix

## Project description

A repository for my declarative configurations for unix like systems. This flake is 
currently being used for home NixOS workstations and my work M1 MacBook. The master 
branch is functional so feel free to use as a reference.

## Architecture

The general idea here is that the hostname of a client machine is associated to a 
`darwinConfigurations` or `nixosConfiguruations` for MacOS and NixOS respectively. This 
is common behavior for most NixOS flakes. One goal of this repository is to abstract
as much of the boilerplate code as possible so that changing users and adding machines
is effortless. This is accomplished with a simple function (one for MacOS and one for
NixOS) that accepts a hostname and system type argument and then builds a standard 
workstation.

The configuration that defines a system is comprised of nix expressions that live 
within several directories. Each directory is intentionally described. The pattern used
is intended to promote logical separation the supports durability for change.

### Preferences

If you are not me and you are trying this environment on your own machine, you will 
need to edit the preferences in `preferences/default.nix`. This file provides options
for your user name, timezone, localization, etc. 

These options can be altered without consequence. That is, if you change these values,
then the build will adapt itself without requiring other changes. The only exception to
this rule is the `nixos-version` option. If this value is changed, the input(s) on 
`flake.nix` will also need to be updated.

### Configurations 

Configurations are abstracted from `configuration.nix` files. These expressions are 
common for specified use cases (e.g., "workstation") and they do not differ between
hosts (i.e. hardware). For example, configurations include system installed packages
such as git, zsh, and btop. Packages here are not user specific and should not require 
home-manager. 

Note that in NixOS systems, expressions in the `configurations` directory will also
define things such as system services and firewall settings.

### Homes 

Homes are user specific configurations. This is where home-manager is implemented and
it is where most user interfaced programs are defined. The nix expressions within the
`homes` directory will, for example, include shell aliases, a customized `gnome`
installation, and Neovim configurations. In other words, expressions with the `homes`
directory are responsible for installing user specific modules.

### Hosts

Expressions within the `hosts` directory are specific to a machine and the hardware on
that machine. Host expressions are responsible for driver settings, boot configurations,
and other hardware enablement. The `hosts` directory will contain a subdirectory for
each NixOS host machine using this flake.

Host configurations are only applicable to NixOS installations as MacOS is not able to
be as awesomely configured as a linux machine.

## MacOS Installation

![macos_preview](/assets/macos_preview.png?raw=true "Preview of MacOS")

### Setup MacOS for Nix Darwin

#### Nix

Install Nix from the shell script on [nixos.org](https://nixos.org/download.html#nix-install-macos).
Next add a config file under `~/.config/nix/nix.conf`. Within the configuration file,
add the following:

```config
experimental-features = nix-command flakes
```

#### Nix Darwin

Install nix darwin from the instructions on their [github page](https://github.com/LnL7/nix-darwin).
The install script should be run from your home directory.  It is not necessary to add 
anything to the nix channels.

#### Disable SIP

The MacOS install uses [Yabai](https://github.com/koekeishiya/yabai) and SKHD. This
requires SIP to be disabled. Follow the instructions on the [yabai wiki](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection).

### Edit the flake for MacOS 

Clone this repository into `~/.nixpkgs`. Then modify `flake.nix` by adding a line in the
set referenced below as described in the comment.

```nix
{
  # Add or change systems here following the pattern below
  #   <hostname> = mkDarwinWorkstation <hostname> <system type>;
  sum-rock-wrk = mkDarwinWorkstation "sum-rock-wrk" "aarch64-darwin";
}
```

If you are not me, the author of this repository, you will also want to change the
values in `preferences/default.nix` so that you use your own username and 
localization settings.

Next, run the following:

```shell~
# This first command may not be necessary
$ nix build ~/.nixpkgs\#darwinConfigurations."$HOST".system
# The flake must be run manually the first time.
$ ~/result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs#
```

After a restart, you should be able to run `darwin-rebuild switch --flake ~/.nixpkgs#`
to rebuild the system going forward.

## NixOS Installation

### Setup New NixOS Install

It is recommended that you start from a graphical installation of the current NixOS
release. This isn't required, but it can make your life easier. Once the basic install
processes is completed head to `/etc/nixos/configuration.nix`. Add the following lines
to this initial configuration.

```nix
{
  networking.hostname = "my-hostname-here";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
```

Make sure that both `git` and `vim` are installed too. Don't worry about making this
configuration beautiful because it is going to become irrelevant once the flake is in 
place.

After the edits are made, rebuild your system from the `configuration.nix` file by
running:

```shell
$ sudo nixos-rebuild switch
```

> NOTE: You'll also need to reboot to have the new hostname take effect

### Edit the flake for NixOS

Clone this repository into `~/.nixpkgs`. Then run the following:

```shell
mkdir ~/.nixpkgs/hosts/$HOST
sudo cp /etc/nixos/configuration.nix ~/.nixpkgs/hosts/$HOST/default.nix
sudo cp /etc/nixos/hardware-configuration.nix ~/.nixpkgs/hosts/$HOST/hardware-configuration.nix
sudo chown $USER:users -R ~/.nixpkgs/hosts/$HOST
```

Modify `flake.nix` by adding a line in the set referenced below as described in the
comment.

```nix
{
  # Add or change systems here following the pattern below
  #   <hostname> = mkNixOSWorkstation <hostname> <system type>;
  xps = mkNixOSWorkstation "xps" "x86_64-linux";
}
```

Next, edit `./hosts/$HOST/default.nix` to only include things that are specific to
this new device. If you look at what is included in `./configurations/nixos.nix` you will 
get an idea of what can be removed. Check the other system `default.nix` files within
the `hosts` directory for additional reference.

You should only require configurations for your bootloader, keyfile path (if your
drive is encrypted), swap partitions, and your hostname. Note the nvidia
configurations available in `hosts/common` can be imported if necessary.

> Note: leave your hardware-configuration.nix alone

#### Special note for those of you who are not me!

If you are not me, the author of this repository, you will want to change the values in
`preferences/default.nix` so that you use your own username and localization settings.

### Rebuild NixOS

If you've just made changes to the flake, you need to commit those changes for Nix to
find them. Commit the changes and build your system from the flake.

```shell
cd ~/.nixpkgs
git add . && git commit -m "a pithy message"
sudo nixos-rebuild boot --flake ~/.nixpkgs#
```

Restart your system and behold your new machine.
