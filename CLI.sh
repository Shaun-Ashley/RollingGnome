#!/bin/bash

set -e

echo "[*] Creating fresh Wiz CLI offline setup..."

# Clean slate
rm -rf wizcli-offline-setup wizcli_offline.zip

# Make directory structure
mkdir -p wizcli-offline-setup/packages
cd wizcli-offline-setup

# Optional: Create a clean venv to isolate pip behavior (not transferred)
python3 -m venv tempenv
source tempenv/bin/activate

# Upgrade pip & setuptools within venv (just to make downloads clean)
pip install --upgrade pip setuptools

# Download wiz-env and all dependencies into packages/
echo "[*] Downloading latest wiz-env and dependencies..."
pip download wiz-env "setuptools>=48.8.0" -d packages

# Save a snapshot of what was downloaded
pip freeze > wiz-requirements.txt

# Deactivate and remove the temporary venv (cleaner ZIP)
deactivate
rm -rf tempenv

cd ..
zip -r wizcli_offline.zip wizcli-offline-setup

echo "[✓] All set! Transfer 'wizcli_offline.zip' to your offline machine."
