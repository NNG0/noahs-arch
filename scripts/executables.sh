#!/usr/bin/env bash
set -euo pipefail

# Get the root directory of dotfiles repo (one level up from the scripts directory)
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "==> Making all repository scripts executable..."

# 1. Make everything in your bin directory executable for the user
if [[ -d "$REPO_DIR/bin" ]]; then
    chmod u+x "$REPO_DIR/bin"/* 2>/dev/null || true
fi

# 2. Automatically find and chmod +x ALL .sh files in the repo
# This completely eliminates having to add files here manually in the future!
find "$REPO_DIR" -type f -name "*.sh" -exec chmod +x {} +

echo "==> Permissions updated successfully."
