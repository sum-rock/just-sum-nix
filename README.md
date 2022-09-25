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

## Commands

Rebuild

```zsh
nixos-rebuild switch --flake github://sum-rock/just-sum-nix/master
```
