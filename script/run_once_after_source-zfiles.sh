#!/bin/bash

echo "[Start] Source Zsh files"

zfiles=(~/.profile
~/.zshrc
~/.zprofile
~/.zshenv)

for file in "${zfiles[@]}"; do
    source "$file"
done

echo "[Complete] Source Zsh files"
