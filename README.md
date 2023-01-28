# Just Sum Nix

## Project description

### What is this?

A repository for sum-rock's declarative configurations for unix like systems.
This flake is currently being used for home NixOS workstations and my work M1 
MacBook. The master branch is functional so feel free to use as a reference.

## Architecture

The general idea here is that the hostname of the client machine is associated
to a `darwinConfigurations` or `nixosConfiguruations` for MacOS and NixOS
respectively. A darwin configuration will require a __bundle__ and a __home__.
NixOS configurations will require a __bundle__, __home__, and a __system__.

### Bundles

Bundles are abstracted system wide configurations. These configurations are 
common for specified use cases and do not differ across hardware. For example,
bundles include system installed packages such as git, zsh, and btop. Packages
here are not user specific and should not require home-manager.

### Homes 

Homes are (potentially) user specific configurations. This is where
home-manager is implemented. The nix files within the homes directory will,
for example, include user specific shell aliases. Homes are also
responsible for importing user specific modules.

### System

System expressions are specific to a machine and the hardware on that machine.
This is only applicable to NixOS installations. System expressions are
responsible for driver settings, boot configurations, and other hardware
enablement.

## Installation

### MacOS Installation

#### Disable SIP

The MacOS install uses [Yabai](https://github.com/koekeishiya/yabai) and SKHD. This
requires SIP to be disabled. Follow the instructions on the [yabai wiki](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection).

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

#### Clone this repository

Clone this repository into `~/.nixkpgs` and then run the following command(s).

```shell
# This first command may not be necessary
$ nix build ~/.nixpkgs\#darwinConfigurations.<host-name>.system
# The flake must be run manually the first time.
$ ~/result/sw/bin/darwin-rebuild switch --flake ~/.nixpkgs#
```

After a restart, you should be able to run `darwin-rebuild switch --flake ~/.nixpkgs#`
to rebuild the system going forward.
