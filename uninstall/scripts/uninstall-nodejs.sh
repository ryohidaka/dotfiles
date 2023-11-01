#!/bin/bash

# List of directories to be deleted
directories=(~/.npm
~/.pnpm-state
~/.volta
~/.yarn
~/.config/yarn)

# Delete the specified directories
for dir in "${directories[@]}"; do
    rm -rf "$dir"
    if [ $? -eq 0 ]; then
        echo "[Node.js] Deletion of $dir successful"
    else
        echo "[Node.js] Deletion of $dir failed"
    fi
done
