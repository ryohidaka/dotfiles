#!/bin/bash

rustup self uninstall

# List of directories to be deleted
directories=(~/.cargo
~/.rustup)

# Delete the specified directories
for dir in "${directories[@]}"; do
    rm -rf "$dir"
    if [ $? -eq 0 ]; then
        echo "[Rust] Deletion of $dir successful"
    else
        echo "[Rust] Deletion of $dir failed"
    fi
done
