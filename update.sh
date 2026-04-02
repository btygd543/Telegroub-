#!/bin/bash
# update.sh - Pull latest changes and restart the bot
# Run this from inside the Telegroub- directory:
#   ./update.sh

set -e

echo "======================================"
echo "  WilliamButcherBot - Update Script"
echo "======================================"

# 1. Pull latest code
echo "[1/3] Pulling latest changes from GitHub..."
git pull

# 2. Activate venv and update dependencies
echo "[2/3] Updating Python dependencies..."
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

# 3. Restart bot if running via screen
echo "[3/3] Restarting bot..."
if screen -list | grep -q "wbb"; then
    screen -S wbb -X quit
    echo "  Stopped existing bot session."
fi

screen -dmS wbb bash -c "source venv/bin/activate && python3 -m wbb"
echo "  Bot started in background screen session 'wbb'."
echo ""
echo "======================================"
echo "  Commands:"
echo "  View logs:    screen -r wbb"
echo "  Detach logs:  Ctrl+A then D"
echo "  Stop bot:     screen -S wbb -X quit"
echo "======================================"
