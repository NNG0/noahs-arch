#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../configs"
stow -t ~ */

echo "all configs linked"
