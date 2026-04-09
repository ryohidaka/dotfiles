# dotfiles

Declarative macOS configuration using [Nix flakes](https://nixos.wiki/wiki/Flakes).

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
| `personal`   | x86_64-darwin  | Personal machine (Intel Mac)          |
| `ci-intel`   | x86_64-darwin  | GitHub Actions runner (Intel)         |
| `ci-silicon` | aarch64-darwin | GitHub Actions runner (Apple Silicon) |

## Apply

### Personal machine

```bash
darwin-rebuild switch --flake path:.#personal --impure
```
