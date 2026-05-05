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
│   │   ├── default.nix    # Platform, user, enableHomebrew, homebrew packages
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
├── lib/
│   ├── default.nix        # mkHostConfig + mkDarwinSystem factory
│   ├── darwin/
│   │   ├── system.nix     # nixpkgs platform, primaryUser, fonts, nix settings
│   │   ├── home-manager.nix
│   │   └── homebrew.nix   # nix-homebrew infra (packages defined per host)
│   └── home/
│       ├── editor/        # Neovim (LazyVim)
│       ├── shell/         # Zsh, Starship
│       ├── terminal/      # WezTerm
│       └── tools/         # git, gpg, ssh, mise, sops, formatter
└── config/
    ├── nvim/              # LazyVim configuration (Lua)
    ├── starship/          # Starship prompt config (TOML)
    └── wezterm/           # WezTerm config (Lua)
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
  git = {
    userName = "Your Name";
    userEmail = "you@example.com";
  };
  gpg.signingKey = "YOUR_GPG_KEY_ID";
  networking = {
    hostName = "your-hostname";
    computerName = "your-hostname";
    localHostName = "your-hostname";
  };
  ssh.github = {
    hostname = "github.com";
    user = "git";
    identityFile = "/Users/<user>/.ssh/github/id_ed25519";
  };
}
```

### 2. Generate age key (for secrets)

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

### 3. Generate SSH key

```bash
mkdir -p ~/.ssh/github
ssh-keygen -t ed25519 -f ~/.ssh/github/id_ed25519 -C "your_email@example.com"
```

### 4. Apply configuration

```bash
darwin-rebuild switch --flake path:.#intel --impure
```

## Secrets

Secrets are managed with [sops](https://github.com/getsentry/sops) + [age](https://github.com/FiloSottile/age).

The age key path is set via `SOPS_AGE_KEY_FILE` in your shell environment after the first rebuild.
