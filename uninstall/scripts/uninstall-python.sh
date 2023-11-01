#!/bin/bash

# List of directories to be deleted
directories=(~/.pyenv
~/.python_history)

# Delete the specified directories
for dir in "${directories[@]}"; do
    rm -rf "$dir"
    if [ $? -eq 0 ]; then
        echo "[Python] Deletion of $dir successful"
    else
        echo "[Python] Deletion of $dir failed"
    fi
done
