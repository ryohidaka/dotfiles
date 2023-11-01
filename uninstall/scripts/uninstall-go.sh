#!/bin/bash

# List of directories to be deleted
directories=(~/.goenv
~/go)

# Delete the specified directories
for dir in "${directories[@]}"; do
    sudo rm -rf "$dir"
    if [ $? -eq 0 ]; then
        echo "[Go] Deletion of $dir successful"
    else
        echo "[Go] Deletion of $dir failed"
    fi
done
