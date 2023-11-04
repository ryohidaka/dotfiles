# dotfiles

## Config

`.config/chezmoi/chezmoi.toml`

```toml
[data]
  [data.git]
    user = ""
    email = ""
```

## Installation

```zsh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply $GITHUB_USERNAME
```

## UnInstall

```zsh
sh uninstall/run.sh
```
