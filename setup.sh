#!/usr/bin/env bash
# setup.sh — First-time setup for DigitalOcean Droplet (Ubuntu 24.04)
#
# Usage (two ways):
#   A) Run from inside a cloned repo:
#        cd ~/Telegroub-  &&  bash setup.sh
#   B) Run from any directory (will clone automatically):
#        bash <(curl -sL https://raw.githubusercontent.com/btygd543/Telegroub-/main/setup.sh)
set -e

REPO_URL="https://github.com/btygd543/Telegroub-"
REPO_DIR="Telegroub-"
VENV_DIR="venv"

echo "=== WilliamButcherBot — DigitalOcean Droplet Setup ==="

# ── Step 1: System packages ─────────────────────────────────
echo "[1/5] Updating system packages..."
apt-get update -y
apt-get upgrade -y

echo "[2/5] Installing system dependencies..."
apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv \
    git curl wget screen \
    ffmpeg \
    build-essential libpq-dev \
    libjpeg-dev zlib1g-dev libpng-dev \
    libxml2-dev libxslt1-dev \
    libssl-dev libffi-dev

# ── Step 2: Ensure we are inside the repo directory ─────────
# Detect whether this script is already running inside the repo
# by checking for pyproject.toml in the same directory as the script.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$SCRIPT_DIR/pyproject.toml" ]; then
    # Script is inside the repo — use its directory
    echo "[3/5] Running from inside the repository ($SCRIPT_DIR)..."
    cd "$SCRIPT_DIR"
else
    # Script is outside the repo — clone it
    echo "[3/5] Cloning repository..."
    if [ -d "$REPO_DIR" ]; then
        echo "  Directory '$REPO_DIR' already exists, pulling latest..."
        cd "$REPO_DIR"
        git pull
    else
        git clone "$REPO_URL" "$REPO_DIR"
        cd "$REPO_DIR"
    fi
fi

# ── Step 3: Python virtual environment ──────────────────────
echo "[4/5] Creating Python virtual environment..."
python3 -m venv "$VENV_DIR"

echo "[5/5] Installing Python dependencies..."
"$VENV_DIR/bin/pip" install --upgrade pip
"$VENV_DIR/bin/pip" install -r requirements.txt

echo ""
echo "========================================================="
echo " ✅  Setup complete!"
echo ""
echo " Next steps:"
echo "  1. cp sample_config.env config.env"
echo "  2. nano config.env          # fill in your tokens"
echo "  3. make run                  # start the bot"
echo ""
echo " Other commands:"
echo "  make stop      — stop the bot"
echo "  make logs      — view live logs"
echo "  make update    — pull + reinstall deps"
echo "  make help      — list all commands"
echo "========================================================="
