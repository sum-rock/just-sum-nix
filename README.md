# Just Sum Nix

## Project description

### What is this?

A repository for sum-rock's declarative configurations for unix like systems.
This flake is currently being used for home NixOS workstations and my work M1 
MacBook. The master branch is functional so feel free to use as a reference.
However, be advised that I am relatively early on the NixOS learning curve.

## Architecture

The general idea here is that the hostname of the client machine is associated
to a `darwinConfigurations` or `nixosConfiguruations` for MacOS and NixOS
respectively. A darwin configuration will require a __bundle__ and a __profile__.
NixOS configurations will require a __bundle__, __profile__, and a __system__.

### Bundles

Bundles are abstracted system wide configurations. These configurations are 
common for specified use cases and do not differ across hardware. For example,
bundles include system installed packages such as git, zsh, and btop. Packages
here are not user specific and should not require home-manager.

### Profiles

Profiles are (potentially) user specific configurations. This is where
home-manager is implemented. The nix files within the profile directory will,
for example, include profile specific shell aliases. Profiles are also
responsible for importing user specific modules. Profiles invoke these modules
with a given username passed into the namespace of the module. Thus the 
contents of the subdirectory `profiles/modules/` cannot be expressed outside a
profile.

### System

System expressions are specific to a machine and the hardware on that machine.
This is only applicable to NixOS installations. System expressions are
responsible for driver settings, boot configurations, and other hardware
enablement.

## Installation

### MacOS

__Caution!__ This is my best recollection of how I was able to get this
working. If I'm honest, there was a lot of keyboard pounding and swearing. The
following should be approximately correct. I believe that the challenge is that
there are some things that need to be set up prior to getting the flake built.
Those steps are frustratingly irrelevant once flakes are in use. I think. 

If you're reading this as a guide just know that it can be done. I am using an
M1 MacBook and this is working. 

#### Install nix

Check [here](https://nixos.org/download.html#nix-install-macos) for the wiki 
reference.

```
sh <(curl -L https://nixos.org/nix/install)
```

Subscribe to the stable channel 

```
nix-channel --add https://nixos.org/channels/nixpkgs-22.05-darwin nixpkgs
```

#### Enable experimental features

Experimental features will need to be enabled to install the flake. This can
be removed later after installation.

`~/.config/nix/nix.conf`
```
{ pkgs, ... }: {
  ...
  nix.settings.experimental-features = [ "nix-command", "flakes" ];
  ...
}
```

#### Install nix darwin

```
nix-channel --add https://github.com/LnL7/nix-darwin/archive/master.tar.gz darwin
nix-channel --update
nix-shell '<darwin>' -A installer
darwin-rebuild switch
```

#### Build the flake

```
git clone https://github.com/sum-rock/just-sum-nix.git ~/.nixpkgs
cd .nixpkgs

darwin-rebuild switch --flake ".#"
```

## NixOS

Comming soon.
