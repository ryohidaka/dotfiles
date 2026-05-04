# dotfiles

[![CI](https://github.com/ryohidaka/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/ryohidaka/dotfiles/actions/workflows/ci.yml)

Declarative macOS configuration using [Nix flakes](https://nixos.wiki/wiki/Flakes).

## Directory Structure

```
.
├── flake.nix              # Flake inputs & darwinConfigurations outputs
├── flake.lock
├── hosts/
│   ├── intel/             # Intel Mac host
│   │   ├── default.nix    # Platform, user
│   │   ├── private.nix    # Git-ignored local values (git, gpg, ssh, networking)
│   │   └── private.nix.example
│   ├── ci-intel/          # GitHub Actions — x86_64-darwin
│   │   ├── default.nix    # CI host definition
│   │   ├── private.nix    # Git-ignored local values (git, gpg, ssh, networking)
│   │   └── private.nix.example
│   └── ci-silicon/        # GitHub Actions — aarch64-darwin
│       ├── default.nix    # CI host definition
│       ├── private.nix    # Git-ignored local values (git, gpg, ssh, networking)
│       └── private.nix.example
└── lib/
    ├── default.nix        # mkHostConfig + mkDarwinSystem factory
    ├── darwin/
    │   ├── system.nix     # nixpkgs platform, primaryUser, nix settings
    │   └── home-manager.nix
    └── home/
        └── tools/         # git, formatter
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

| Host         | Platform       | Description                           |
| ------------ | -------------- | ------------------------------------- |
| `intel`      | x86_64-darwin  | Intel Mac                             |
| `ci-intel`   | x86_64-darwin  | GitHub Actions runner (Intel)         |
| `ci-silicon` | aarch64-darwin | GitHub Actions runner (Apple Silicon) |

## Setup

### 1. Configure private values

Copy the example file and fill in your values (this file is git-ignored):

```bash
cp hosts/intel/private.nix.example hosts/intel/private.nix
```

Edit `hosts/intel/private.nix`:

```nix
{
  networking = {
    hostName = "your-hostname";
    computerName = "your-hostname";
    localHostName = "your-hostname";
  };
}
```

### 2. Apply configuration

```bash
darwin-rebuild switch --flake path:.#intel --impure
```
