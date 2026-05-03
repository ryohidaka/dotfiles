# dotfiles

[![CI](https://github.com/ryohidaka/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/ryohidaka/dotfiles/actions/workflows/ci.yml)

Declarative macOS configuration using [Nix flakes](https://nixos.wiki/wiki/Flakes).

## Directory Structure

```
.
├── flake.nix              # Flake inputs & darwinConfigurations outputs
├── flake.lock
├── hosts/
│   └── intel/             # Intel Mac host
│       └── default.nix    # Platform, user
└── lib/
    ├── default.nix        # mkDarwinSystem factory
    └── darwin/
        └── system.nix     # nixpkgs platform, primaryUser, nix settings
```

## Prerequisites

- macOS
- [Determinate Nix](https://determinate.systems/nix-installer)

### Intel Mac

> [!WARNING]
> Pinned to v3.12.2 — last version supporting x86_64-darwin
>
> https://github.com/DeterminateSystems/nix-installer/issues/1707

> [!NOTE]
> Review the installer script before running:
> https://install.determinate.systems/nix/tag/v3.12.2

```bash
curl -fsSL https://install.determinate.systems/nix/tag/v3.12.2 | sh -s -- install
```

### Apple Silicon Mac

> [!NOTE]
> Review the installer script before running:
> https://install.determinate.systems/nix

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

## Hosts

| Host    | Platform      | Description |
| ------- | ------------- | ----------- |
| `intel` | x86_64-darwin | Intel Mac   |

## Setup

### Apply configuration

```bash
darwin-rebuild switch --flake path:.#intel --impure
```
