#!/bin/bash
echo "[Start] Install pre-commit"

echo 'if chezmoi apply --dry-run 2>&1; then
  echo "chezmoi dry-run passed. Committing..."
  exit 0
else
  echo "chezmoi dry-run failed. Aborting commit."
  exit 1
fi' > .git/hooks/pre-commit

chmod +x .git/hooks/pre-commit

echo "[Complete] Install pre-commit"
