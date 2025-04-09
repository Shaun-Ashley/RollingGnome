#!/bin/bash

set -e

echo "[*] Starting offline Wiz CLI install..."

# Unzip if needed
if [ ! -d "wizcli-offline-setup" ]; then
    echo "[*] Unzipping wizcli_offline.zip..."
    unzip wizcli_offline.zip
fi

cd wizcli-offline-setup

# Create and activate virtual environment
echo "[*] Creating and activating virtual environment..."
python3 -m venv env
source env/bin/activate

# Install essential build tools (already pre-downloaded)
echo "[*] Installing setuptools and wheel..."
pip install --no-index --find-links=packages "setuptools>=48.8.0" wheel

# Install wiz-env using pre-downloaded packages and disable build isolation
echo "[*] Installing Wiz CLI (wiz-env) using offline packages..."
pip install --no-index --find-links=packages --no-build-isolation wiz-env

echo "[✓] Wiz CLI installed successfully!"
wiz --version
