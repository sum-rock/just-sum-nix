# Just Sum Nix

![niri_nixos](/assets/niri_nixos.png?raw=true "Preview of Niri on NixOS")

## Project description

A repository containing declarative configurations for unix like systems. This flake is
currently being used on several home NixOS workstations and my M4 MacBook that I use for
work. The master branch is functional so feel free to use as a reference. You may also
attempt to build the configuration as-is on your own machine, however several
modifications are required. See
[Modifications For the Pubic](#modifications-for-the-public).

## Architecture

The general idea is that the hostname of a client machine is associated to a
`darwinConfigurations` or `nixosConfigurations` for MacOS and NixOS respectively. This
is common behavior for most NixOS flakes. One goal of this repository is to abstract
as much of the boilerplate code as possible so that changing users and adding machines
is effortless. This is accomplished with a simple function (one for MacOS and one for
NixOS) that accepts a hostname and system type argument and then builds a standard
workstation.

The configuration that defines a system is comprised of Nix modules that live
within several directories. Each directory is intentionally described and the pattern
used is intended to promote logical separation that ultimately supports durability
for change.

<details>
  <summary>Click for specifics</summary>

### Preferences

If you are not me and you are trying this environment on your own machine, you will
need to edit the preferences in `preferences/default.nix`. This file provides options
for your user name, timezone, localization, etc.

These options can be altered without consequence. That is, if you change these values,
then the build will adapt itself without requiring other changes. The only exception to
this rule is the `nixos-version` option. If this value is changed, the input(s) on
`flake.nix` will also need to be updated.

### Configurations

Configurations are abstracted from `configuration.nix` files. These
expressions are common for all workstations and do not differ between hosts.
For example, configurations include system installed packages such as git,
zsh, and btop. Packages here are not user specific and should not require
home-manager.

Note that in NixOS systems, expressions in the `configurations` directory will also
define things such as system services and firewall settings.

### Homes

Homes are user specific configurations. This is where home-manager is implemented and
it is where most user interfaced programs are defined. The nix expressions within the
`homes` directory will, for example, include shell aliases, a customized `Niri`
installation, and terminal configurations. In other words, expressions with the `homes`
directory are responsible for installing user specific modules.

#### Neovim Note

Neovim is configured using an implementation of [AstroNvim](https://astronvim.com/)
that is defined in an external flake
[SumAstroNvim](https://github.com/sum-rock/SumAstroNvim). See the SumAstroNvim repo for
more information.

### Hosts

Expressions within the `hosts` directory are specific to a machine and the hardware on
that machine. Host expressions are responsible for driver settings, boot configurations,
and other hardware enablement. The `hosts` directory will contain a subdirectory for
each NixOS host machine using this flake.

Host configurations are only applicable to NixOS installations as MacOS is not able to
be as awesomely configured as a linux machine.

</details>

## Modifications for the Public

If you would like to install this flake on your system, you will want to fork
this repo and make the following changes.

- Remove the `private` input on `flake.nix`
- Remove the modules imported from `private` in the `nixosConfigurations` function
- Remove the directories in `hosts` that represent my computers, leaving `common`.
- Update `preferences/default.nix` with your info.
