#!/bin/bash

# Delete the specified directories individually
rm -rf ~/.pyenv

if [ $? -eq 0 ]; then
    echo "[Python] Deletion successful"
else
    echo "[Python] Deletion failed"
fi
