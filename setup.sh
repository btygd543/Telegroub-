#!/bin/bash
# setup.sh - First-time setup script for DigitalOcean Droplet
# Run this once after cloning the repository:
#   chmod +x setup.sh && ./setup.sh

set -e

echo "======================================"
echo "  WilliamButcherBot - Setup Script"
echo "======================================"

# 1. Install system dependencies
echo "[1/5] Installing system packages..."
apt-get update -y
# python3-venv covers all Python 3.x versions; on Ubuntu 24.04 this installs python3.12-venv
apt-get install -y python3-venv python3-pip ffmpeg git

# 2. Create virtual environment
echo "[2/5] Creating virtual environment..."
python3 -m venv venv
source venv/bin/activate

# 3. Upgrade pip and install dependencies
echo "[3/5] Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# 4. Copy config template if not already present
echo "[4/5] Setting up config file..."
if [ ! -f config.env ]; then
    cp sample_config.env config.env
    echo ""
    echo "  *** IMPORTANT: Edit config.env with your own values! ***"
    echo "      nano config.env"
    echo ""
else
    echo "  config.env already exists, skipping."
fi

# 5. Done
echo "[5/5] Setup complete!"
echo ""
echo "======================================"
echo "  Next steps:"
echo "  1. Edit config.env:  nano config.env"
echo "  2. Activate venv:    source venv/bin/activate"
echo "  3. Run the bot:      python3 -m wbb"
echo "  (or use: make run)"
echo "======================================"
