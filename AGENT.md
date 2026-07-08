# Agent Guidelines for this Repo

This repository is a Nix flake used to build system configurations for
macOS (nix-darwin) and NixOS machines. Read this before making changes.

## Hard Rules — Never Do These

- **Never build or activate the system.** Do not run:
  - `darwin-rebuild switch`, `darwin-rebuild build`, or any `darwin-rebuild` subcommand
  - `nixos-rebuild switch`, `nixos-rebuild build`, `nixos-rebuild boot`, or any `nixos-rebuild` subcommand
  - `nix flake check`
  - `nix build` against this flake's outputs (e.g. `.#darwinConfigurations.*`, `.#nixosConfigurations.*`)
  - `home-manager switch`
- Build and evaluate commands require `sudo` privilage. You do not have `sudo` privilage.
- If a task seems to require verifying that the flake builds, **say so and
  stop** — propose the exact command for the human to run themselves, rather
  than running it.

## What the Agent CAN Do

- Read and edit any files in the repository
- Run `nix flake metadata` / `nix flake show` to inspect flake outputs (these
  are read-only/informational and do not evaluate derivations).
- Run `nix eval` on narrow, specific attributes when needed to sanity-check
  syntax or a value (e.g. `nix eval .#nixosConfigurations.hostname.config.some.option`),
  as long as it's scoped and not a full `nix flake check` or full closure build.
- Run formatters/linters (e.g. `nixpkgs-fmt`, `alejandra`, `statix`, `deadnix`) on individual files.
- Search the repo, explain structure, and propose diffs.
- Update specific flake inputs in `flake.lock` via `nix flake update` **only if
  explicitly asked to**, and note that this changes pinned versions.

## Style / Conventions

- Match existing formatting conventions in the repo rather than introducing
  a new style; check for an existing formatter config first.
- Prefer small, targeted diffs. Avoid reflowing or reformatting unrelated
  code.
- When adding a new option or module, follow the pattern of nearby
  similar modules (naming, `mkOption`/`mkEnableOption` usage, `lib` helpers).

## When Uncertain

- If a change might affect system activation behavior (e.g. modifying
  `system.stateVersion`, bootloader config, service definitions), flag this
  explicitly in your response so the human can review carefully before
  building.
- Never assume it's safe to test by building — always defer that step to
  the human.
