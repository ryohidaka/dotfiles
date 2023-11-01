#!/bin/bash

DIR=./uninstall/scripts

# Delete chezmoi cache
sh $DIR/remove-chezmoi-cache.sh

# Uninstall homebrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
sudo sh $DIR/uninstall-homebrew.sh
