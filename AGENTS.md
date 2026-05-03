# AGENTS.md

This file provides context and conventions for AI agents (and contributors) working in this repository.

## Project Overview

A fully declarative macOS dotfiles system using **Nix flakes** and **nix-darwin**.
The goal is a reproducible, multi-host configuration with clean separation of concerns and independent buildability of every commit.

### Hosts

| Hostname | Architecture | User | Notes |
| -------- | ------------ | ---- | ----- |
|          |              |      |       |

---

## Architecture

`flake.nix` uses a **factory pattern** that assembles each host from per-host files under `hosts/`:

- Per-host files under `hosts/` define the nix-darwin settings for each machine
- `mkDarwinSystem` — composes those host-specific settings into a final `darwinSystem`

---

## Commit Conventions

Commits follow **Conventional Commits** with the scoping rules below.
Always write commit messages in **English**.

| Scope                    | Prefix       | When to use                                         |
| ------------------------ | ------------ | --------------------------------------------------- |
| Entire Nix configuration | `feat(nix):` | Flake-level or cross-cutting Nix changes            |
| CI                       | `ci:`        | GitHub Actions workflows                            |
| Chores / tooling         | `chore:`     | Formatting, lock file bumps, non-functional changes |
| Documentation            | `docs:`      | Docs-only changes (always a separate commit)        |

**Examples**

```
feat(nix): add sops-nix and age secret management
ci: add darwin build matrix for intel and silicon runners
chore: update flake.lock
docs: document sops age key path workaround
```
