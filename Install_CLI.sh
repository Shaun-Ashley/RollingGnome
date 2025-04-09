#!/bin/bash

set -e

echo "[*] Starting offline Wiz CLI install..."

# Unzip if needed
if [ ! -d "wizcli-offline-setup" ]; then
    echo "[*] Unzipping package..."
    unzip wizcli_offline.zip
fi

cd wizcli-offline-setup

# Create and activate virtual environment
python3 -m venv env
source env/bin/activate

# Install setuptools first (from downloaded packages)
echo "[*] Installing setuptools..."
pip install --no-index --find-links=packages "setuptools>=48.8.0"

# Install Wiz CLI
echo "[*] Installing Wiz CLI..."
pip install --no-index --find-links=packages wiz-env

echo "[✓] Installation complete. Verifying..."
wiz --version
