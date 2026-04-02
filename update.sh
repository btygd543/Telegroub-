#!/usr/bin/env bash
# update.sh — Pull latest code and reinstall dependencies
set -e

BRANCH="main"
VENV_DIR="venv"

echo "[1/3] Pulling latest changes from origin/${BRANCH}..."
git pull origin "$BRANCH"

echo "[2/3] Upgrading Python dependencies..."
"$VENV_DIR/bin/pip" install --upgrade pip
"$VENV_DIR/bin/pip" install -r requirements.txt

echo "[3/3] Update complete! Restart the bot to apply changes."
echo "  Run: make run"
