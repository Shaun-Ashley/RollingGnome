#!/bin/bash

set -e

echo "[*] Starting fresh Wiz CLI offline prep..."

# Clean previous setup if it exists
rm -rf wizcli-offline-setup wizcli_offline.zip

# Create folder structure
mkdir -p wizcli-offline-setup/packages
cd wizcli-offline-setup

# Optional: create clean venv to ensure isolated downloads
python3 -m venv tempenv
source tempenv/bin/activate

# Upgrade tooling (not required, but clean)
pip install --upgrade pip setuptools

# Download Wiz CLI and all required dependencies
echo "[*] Downloading packages..."
pip download wiz-env -d packages

# Download known native dependency (ujson)
pip download ujson -d packages

# Download required build support (setuptools & wheel)
pip download "setuptools>=48.8.0" wheel -d packages

# Optional: save version list
pip freeze > wiz-requirements.txt

# Deactivate and clean up the temp venv
deactivate
rm -rf tempenv

cd ..
zip -r wizcli_offline.zip wizcli-offline-setup

echo "[✓] Done! Move 'wizcli_offline.zip' to your offline machine."
