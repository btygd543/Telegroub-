#!/bin/bash
# setup.sh - First-time setup script for Ubuntu 24.04 DigitalOcean Droplet

set -e

if [[ $EUID -ne 0 ]]; then
    echo "Error: This script must be run as root (use sudo or run as root)." >&2
    exit 1
fi

BOT_NAME="wbb_bot"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing python3.12-venv if not present..."
if ! dpkg -s python3.12-venv &>/dev/null; then
    apt install -y python3.12-venv
fi

echo "==> Creating virtual environment..."
python3 -m venv "$PROJECT_DIR/venv"

echo "==> Activating virtual environment and installing dependencies..."
"$PROJECT_DIR/venv/bin/pip" install --upgrade pip
"$PROJECT_DIR/venv/bin/pip" install -r "$PROJECT_DIR/requirements.txt"

echo "==> Checking for config.env..."
if [ ! -f "$PROJECT_DIR/config.env" ]; then
    cp "$PROJECT_DIR/sample_config.env" "$PROJECT_DIR/config.env"
    echo ""
    echo "  *** IMPORTANT ***"
    echo "  config.env has been created from sample_config.env."
    echo "  Please edit it with your values before running the bot:"
    echo "    nano $PROJECT_DIR/config.env"
    echo ""
fi

echo "==> Starting bot inside screen session '$BOT_NAME'..."
screen -dmS "$BOT_NAME" bash -c "cd $PROJECT_DIR && source venv/bin/activate && python3 -m wbb"

echo ""
echo "✅ Setup complete! Bot is running in screen session '$BOT_NAME'."
echo "   Use 'screen -r $BOT_NAME' to attach, or 'make logs' to view output."
