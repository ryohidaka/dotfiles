#!/bin/bash

# Check if 'chezmoi' command is available
if command -v chezmoi &> /dev/null; then
    # 'chezmoi' command is available, so delete the bucket
    chezmoi state delete-bucket --bucket=scriptState
else
    # 'chezmoi' command is not available, so skip this step
    echo "[Chezmoi] chezmoi is not available. Skipping the operation."
fi

# List of directories to be deleted
directories=(~/bin/chezmoi
~/.config/chezmoi
~/.local/share/sheldon)

# Delete the specified directories
for dir in "${directories[@]}"; do
    sudo rm -rf "$dir"
    if [ $? -eq 0 ]; then
        echo "[Chezmoi] Deletion of $dir successful"
    else
        echo "[Chezmoi] Deletion of $dir failed"
    fi
done
