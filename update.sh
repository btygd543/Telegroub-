#!/usr/bin/env bash
# update.sh — Pull latest code and reinstall dependencies
# Run from inside the Telegroub- directory.
set -e

VENV_DIR="venv"

# Ensure we're in the repo root (same directory as this script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

BRANCH="$(git rev-parse --abbrev-ref HEAD)"

echo "[1/3] Pulling latest changes (branch: ${BRANCH})..."
git pull origin "$BRANCH"

echo "[2/3] Upgrading Python dependencies..."
"$VENV_DIR/bin/pip" install --upgrade pip
"$VENV_DIR/bin/pip" install -r requirements.txt

echo "[3/3] Update complete! Restart the bot to apply changes."
echo "  Run: make restart"
