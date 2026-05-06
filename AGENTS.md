# AGENTS.md

This file provides context and conventions for AI agents (and contributors) working in this repository.

## Project Overview

A fully declarative macOS dotfiles system using **Nix flakes**, **nix-darwin**, and **home-manager**.
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

- `mkHostConfig` — nix-darwin system settings
- `mkHomeManagerConfig` — home-manager user settings
- `mkHomebrewModules` — Homebrew packages
- `mkDarwinSystem` — composes those host-specific settings into a final `darwinSystem`, including shared modules such as `sops-nix`

Config files (Lua/TOML dotfiles for LazyVim, WezTerm, Starship, etc.) live in `config/` and are
referenced via `flakeRoot` passed through `extraSpecialArgs`.

---

## Key Principles

1. **Every commit must build independently.** Feature commits and docs commits are always kept separate.
2. **Prefer home-manager for user tools** (nix-fmt/treefmt, lefthook, Starship, etc.) so they are
   available in the managed environment, not only in the flake dev shell.
3. **home-manager owns its dotfiles.** Any file managed by home-manager (e.g. `~/.config/starship.toml`)
   is a symlink — manual edits will be overwritten on rebuild. Apply presets/patches via Nix config instead.
4. **Secrets stay out of the store.** Use `path:.#<host> --impure` (not `git+file://`) so git-ignored
   files like `private.nix` and age keys can be accessed at build time.

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
| home-manager, all hosts  | `feat(home):`       | home-manager module changes that apply everywhere   |
| Specific host only       | `feat(<hostname>):` | Changes scoped to one host (e.g. `feat(intel):`)    |
| CI                       | `ci:`               | GitHub Actions workflows                            |
| Chores / tooling         | `chore:`            | Formatting, lock file bumps, non-functional changes |
| Documentation            | `docs:`             | Docs-only changes (always a separate commit)        |

**Examples**

```
feat(nix): add sops-nix and age secret management
feat(home): integrate Starship via initContent for controlled load order
feat(intel): configure WezTerm with JetBrainsMono Nerd Font
ci: add darwin build matrix for intel and silicon runners
chore: update flake.lock
docs: document sops age key path workaround
```

---

## Shell & Terminal Stack

- **Shell**: Zsh managed by home-manager
  - Starship integrated via manual `initContent` (not `programs.starship.enableZshIntegration`) to
    control load order relative to WezTerm shell integration
- **Terminal**: WezTerm with JetBrainsMono Nerd Font (`pkgs.nerd-fonts.jetbrains-mono`)
- **Prompt**: Starship config managed via Nix
- **Editor**: Neovim via LazyVim (`config/nvim`)

---

## Secrets (sops-nix + age)

- Age key path set via `SOPS_AGE_KEY_FILE` environment variable (overrides macOS default)
- `.sops.yaml` `path_regex` patterns are relative to the file's location — do **not** prefix with `secrets/`
  - Correct: `intel\.yaml$`
  - Incorrect: `secrets/intel\.yaml$`

---

## Known Gotchas

| Issue                                     | Resolution                                               |
| ----------------------------------------- | -------------------------------------------------------- |
| Build fails without `system.primaryUser`  | Always set `system.primaryUser` in nix-darwin config     |
| `environment` vs `home.packages` mismatch | Use `home.packages` inside home-manager modules          |
| `darwinModules` optionals line missing    | Ensure `mkDarwinSystem` includes the optionals line      |
| `.sops.yaml` regex not matching           | Check path prefix — patterns are relative, not absolute  |
| sops age key path mismatch on macOS       | Set `SOPS_AGE_KEY_FILE` explicitly in `sessionVariables` |

---

## Formatter & Linting

- **Nix**: `nix fmt` / `treefmt` (using `nixfmt`)
- **Lua**: `stylua`
- **TOML**: `taplo`
- **Markdown**: `oxfmt`
- **YAML**: `oxfmt`
- **Git hooks**: `lefthook`

All tools are installed via home-manager, so they are available in the managed shell environment.

After initial setup, run `lefthook install` in the repository to enable the Git hooks locally.
Installing `lefthook` via home-manager makes the binary available, but does not by itself activate the hooks.
