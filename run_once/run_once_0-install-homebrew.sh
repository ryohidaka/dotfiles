#!/bin/bash
echo "[Start] Install homebrew packages."

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

cd ~/

brew bundle

echo "[Completed] Install homebrew packages."
