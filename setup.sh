#!/bin/bash
# Setup script for DigitalOcean Droplet deployment
set -e

echo "=== WilliamButcherBot - DigitalOcean Droplet Setup ==="

# Update system packages
echo "[1/6] Updating system packages..."
apt-get update -y
apt-get upgrade -y

# Install required system packages
echo "[2/6] Installing system dependencies..."
apt-get install -y python3 python3-pip python3-venv git screen ffmpeg

# Clone or update the repo
if [ ! -d "Telegroub-" ]; then
    echo "[3/6] Cloning repository..."
    git clone https://github.com/btygd543/Telegroub-
    cd Telegroub-
else
    echo "[3/6] Repository already exists, skipping clone..."
    cd Telegroub-
fi

# Create virtual environment
echo "[4/6] Creating Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
echo "[5/6] Installing Python dependencies..."
pip install --upgrade pip
pip install -r requirements.txt

# Setup config
echo "[6/6] Setting up configuration..."
if [ ! -f "config.py" ]; then
    cp sample_config.py config.py
    echo ""
    echo "=== IMPORTANT ==="
    echo "Edit config.py with your own values before running the bot:"
    echo "  nano config.py"
    echo ""
fi

echo "=== Setup complete! ==="
echo ""
echo "To start the bot:"
echo "  source venv/bin/activate"
echo "  python3 -m wbb"
echo ""
echo "To run in background with screen:"
echo "  make run"
