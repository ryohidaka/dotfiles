#!/bin/bash
echo "[Start] Install Node.js"

# Install volta
curl https://get.volta.sh | bash

# Install Node.js
volta install node
node --version
npm --version

echo "[Complete] Install Node.js"
