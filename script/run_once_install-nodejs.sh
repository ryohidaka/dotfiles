#!/bin/bash
echo "[Start] Install Node.js"

# Install volta
curl https://get.volta.sh | bash

# Install Node.js
volta install node
node --version
npm --version

# Install yarn
volta install yarn
yarn --version

echo "[Complete] Install Node.js"
