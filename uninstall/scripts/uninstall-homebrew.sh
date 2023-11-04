#!/bin/bash

# List of directories to be deleted
directories=(
# /usr/local/Frameworks/
# /usr/local/Homebrew/
# /usr/local/bin/
# /usr/local/etc/
# /usr/local/include/
# /usr/local/lib/
# /usr/local/n/
# /usr/local/opt/
# /usr/local/sbin/
# /usr/local/share/
# /usr/local/var/
~/Brewfile
~/Brewfile.lock.json)

# Delete the specified directories
for dir in "${directories[@]}"; do
    sudo rm -rf "$dir"
    if [ $? -eq 0 ]; then
        echo "[HomeBrew] Deletion of $dir successful"
    else
        echo "[HomeBrew] Deletion of $dir failed"
    fi
done
