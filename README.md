# Just Sum Nix

## Project description

### What is this?

A repository for sum-rock's declarative configurations for unix like systems.
This flake is currently being used for home workstations. While in a functional
state, please be aware that I am early on the NixOS learning curve. It is
therefore, probably not wise to copy anything you find here. 

### What will this be?

Future iterations will expand functionality along these points. 

 - Purpose built server configurations 
 - A Nix-Darwin implementation so that my gross MacBook that I have to use at
   work can be is cleansed with a little bit of immutable and declarative holy
   fire.

## Structure

The general framework at play here is that a physical machine is associated to a
systems within the directory that shares it's hostname. (This is the default way
in which a flake works.) A system configuration, in this repo, is made up of a
bundle and an optional desktop. While many similar repos implement a `homes`
directory, I've chosen to skip that for the time being. The consequence of that
lazyness is that all systems with the workstation bundle will have a user named
`august` and all server bundle will have a user named `admin`.

Note that each system must import a bundle. All bundles include the common 
configuration located in the `bundles/components/common` directory. Beyond that,
and each bundle contains a unique collection of applications found in the 
`bundles/components/apps` directory. A system may also include a desktop or
window manager from the `desktop` directory. Desktops will need to be considered
in the context of a bundle. That is, not all desktops will work with all bundles
because some applications are referenced within a desktops configuration.

## Commands

Rebuild

```zsh
nixos-rebuild switch --flake github://sum-rock/just-sum-nix/master
```

