#!/bin/bash
# Update script - pulls latest changes from GitHub and restarts the bot
set -e

echo "=== WilliamButcherBot - Update Script ==="

# Pull latest changes
echo "[1/3] Pulling latest changes from GitHub..."
git pull origin main

# Activate virtual environment and update dependencies
echo "[2/3] Updating Python dependencies..."
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

echo "[3/3] Update complete!"
echo ""
echo "Restart the bot to apply changes:"
echo "  make run"
