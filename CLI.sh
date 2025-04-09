#!/bin/bash

# Exit immediately if something fails
set -e

# Create and activate virtual environment
echo "[*] Creating virtual environment..."
python3 -m venv env
source env/bin/activate

# Install setuptools first
echo "[*] Installing setuptools..."
pip install --no-index --find-links=packages "setuptools>=48.8.0"

# Install Wiz CLI and dependencies
echo "[*] Installing Wiz CLI (wiz-env)..."
pip install --no-index --find-links=packages wiz-env

# Confirm success
echo "[*] Wiz CLI installation complete!"
wiz --version
