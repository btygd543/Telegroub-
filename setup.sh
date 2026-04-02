#!/usr/bin/env bash
# setup.sh — First-time setup for DigitalOcean Droplet (Ubuntu 24.04)
set -e

REPO_URL="https://github.com/btygd543/Telegroub-"
REPO_DIR="Telegroub-"
BRANCH="main"
VENV_DIR="venv"

echo "[1/6] Updating system packages..."
apt-get update -y
apt-get install -y --no-install-recommends \
    python3 python3-pip python3-venv \
    git curl wget \
    ffmpeg \
    build-essential \
    libpq-dev

echo "[2/6] Installing system dependencies for Python packages..."
apt-get install -y --no-install-recommends \
    libjpeg-dev zlib1g-dev libpng-dev \
    libxml2-dev libxslt1-dev \
    libssl-dev libffi-dev

echo "[3/6] Cloning repository (branch: ${BRANCH})..."
if [ -d "$REPO_DIR" ]; then
    echo "Directory '$REPO_DIR' already exists. Pulling latest changes..."
    cd "$REPO_DIR"
    git pull origin "$BRANCH"
    cd ..
else
    git clone --branch "$BRANCH" "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"

echo "[4/6] Creating Python virtual environment..."
python3 -m venv "$VENV_DIR"

echo "[5/6] Installing Python dependencies..."
"$VENV_DIR/bin/pip" install --upgrade pip
"$VENV_DIR/bin/pip" install -r requirements.txt

echo "[6/6] Setup complete!"
echo ""
echo "========================================================"
echo " Next steps:"
echo "  1. Copy the sample config:  cp sample_config.env config.env"
echo "  2. Edit config.env with your tokens and credentials."
echo "  3. Run the bot:             make run"
echo "     (or: source venv/bin/activate && python -m wbb)"
echo "========================================================"
