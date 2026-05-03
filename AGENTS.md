# AGENTS.md

This file provides context and conventions for AI agents (and contributors) working in this repository.

## Project Overview

A fully declarative macOS dotfiles system using **Nix flakes** and **nix-darwin**.
The goal is a reproducible, multi-host configuration with clean separation of concerns and independent buildability of every commit.

### Hosts

| Hostname     | Architecture  | User        | Notes                         |
| ------------ | ------------- | ----------- | ----------------------------- |
| `intel`      | Intel Mac     | `ryohidaka` | Intel Mac host                |
| `ci-intel`   | Intel Mac     | `runner`    | GitHub Actions Intel target   |
| `ci-silicon` | Apple Silicon | `runner`    | GitHub Actions Silicon target |

---

## Architecture

`flake.nix` uses a **factory pattern** that assembles each host from per-host files under `hosts/`:

- Per-host files under `hosts/` define the nix-darwin settings for each machine
- `mkDarwinSystem` — composes those host-specific settings into a final `darwinSystem`

---

## Build Commands

```bash
# Build & switch (intel host, git-ignored files required)
darwin-rebuild switch --flake path:.#intel --impure

# Check without switching
nix build path:.#darwinConfigurations.intel.system --impure
```

---

## Commit Conventions

Commits follow **Conventional Commits** with the scoping rules below.
Always write commit messages in **English**.

| Scope                    | Prefix              | When to use                                         |
| ------------------------ | ------------------- | --------------------------------------------------- |
| Entire Nix configuration | `feat(nix):`        | Flake-level or cross-cutting Nix changes            |
| Specific host only       | `feat(<hostname>):` | Changes scoped to one host (e.g. `feat(intel):`)    |
| CI                       | `ci:`               | GitHub Actions workflows                            |
| Chores / tooling         | `chore:`            | Formatting, lock file bumps, non-functional changes |
| Documentation            | `docs:`             | Docs-only changes (always a separate commit)        |

**Examples**

```
feat(nix): add sops-nix and age secret management
feat(intel): configure WezTerm with JetBrainsMono Nerd Font
ci: add darwin build matrix for intel and silicon runners
chore: update flake.lock
docs: document sops age key path workaround
```
