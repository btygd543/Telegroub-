#!/bin/bash
# update.sh - Pull latest changes from GitHub and restart the bot

set -e

if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root (use sudo or run as root)." >&2
    exit 1
fi

BOT_NAME="wbb_bot"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Pulling latest changes from GitHub..."
git -C "$PROJECT_DIR" pull

echo "==> Stopping old bot instance (if running)..."
if screen -list | grep -q "$BOT_NAME"; then
    screen -S "$BOT_NAME" -X quit
    echo "   Old bot stopped."
else
    echo "   No running bot found, skipping stop."
fi

echo "==> Reinstalling dependencies (in case requirements changed)..."
"$PROJECT_DIR/venv/bin/pip" install --upgrade pip
"$PROJECT_DIR/venv/bin/pip" install -r "$PROJECT_DIR/requirements.txt"

echo "==> Starting bot inside screen session '$BOT_NAME'..."
screen -dmS "$BOT_NAME" bash -c "cd $PROJECT_DIR && source venv/bin/activate && python3 -m wbb"

echo ""
echo "✅ Update complete! Bot is running in screen session '$BOT_NAME'."
echo "   Use 'screen -r $BOT_NAME' to attach, or 'make logs' to view output."
