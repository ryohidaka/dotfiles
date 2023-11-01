#!/bin/bash

# Reset zsh files.
> ~/.profile
> ~/.zshrc
> ~/.zprofile
> ~/.zshenv

# List of directories to be deleted
directories=(~/.zsh_history
~/.zsh_sessions
~/.zsh_sessions
~/.config/sheldon
~/.local/share/sheldon
~/.p10k.zsh)

# Delete the specified directories
for dir in "${directories[@]}"; do
    rm -rf "$dir"
    if [ $? -eq 0 ]; then
        echo "[Zsh] Deletion of $dir successful"
    else
        echo "[Zsh] Deletion of $dir failed"
    fi
done
