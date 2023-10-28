#!/bin/bash
echo "[Start] Install Python"
PYTHON_VERSION=$(pyenv install --list | grep -E "^\s+\d+\.\d+\.\d+$" | tail -n 1 | tr -d '[:space:]')

pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

python3 --version

echo "[Complete] Install Python"
