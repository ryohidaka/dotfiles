# dotfiles

[![CI](https://github.com/ryohidaka/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/ryohidaka/dotfiles/actions/workflows/ci.yml)

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

## Secrets

Secrets are managed with [sops](https://github.com/getsentry/sops) + [age](https://github.com/FiloSottile/age).

### Generate age key

```bash
# Create key directory
mkdir -p ~/.config/sops/age

# Generate age key (one-time, using nix shell)
nix shell nixpkgs#age --command age-keygen -o ~/.config/sops/age/keys.txt

# Show public key — add this to .sops.yaml
grep "public key" ~/.config/sops/age/keys.txt
```

> [!WARNING]
> Keep `~/.config/sops/age/keys.txt` secret. Never commit it to the repository.

## Apply

### Personal machine

```bash
darwin-rebuild switch --flake path:.#personal --impure
```

## SSH Keys

SSH keys are managed per host under `~/.ssh/<host>/`.

### Generate SSH key

```bash
# Create key directory
mkdir -p ~/.ssh/github

# Generate SSH key
ssh-keygen -t ed25519 -f ~/.ssh/github/id_ed25519 -C "your_email@example.com"
```

> [!NOTE]
> Set the path in `private.nix` to match:
>
> ```nix
> identityFile = "/Users/<user>/.ssh/github/id_ed25519";
> ```
