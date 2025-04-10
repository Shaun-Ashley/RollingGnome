#!/bin/bash
# Offline Install Script for Wiz CLI on Primary Device (M1 Mac, macOS Sequoia)
# This script assumes it’s run from within the extracted folder (wizcli-offline-setup)
#
# Usage:
#   cd wizcli-offline-setup
#   ./install_offline_wizcli.sh
#
# It creates a virtual environment, installs setuptools and wheel from local files,
# then installs wiz-env and its dependencies offline.

set -euo pipefail

# Change to the directory where this script is located
cd "$(dirname "$0")"

echo "[*] Starting Wiz CLI offline installation..."

# Validate that all required wheels exist in the local packages directory
for pattern in "wiz_env-*.whl" "ujson-*.whl" "setuptools-*.whl" "wheel-*.whl"; do
    if ! ls packages/"$pattern" >/dev/null 2>&1; then
        echo "[✗] ERROR: Missing required wheel: $pattern"
        exit 1
    fi
done

echo "[*] Creating Python virtual environment..."
python3 -m venv env
source env/bin/activate

echo "[*] Installing offline tools (setuptools and wheel) from local packages..."
pip install --no-index --find-links=packages setuptools wheel

echo "[*] Installing Wiz CLI (wiz-env) from offline packages..."
pip install --no-index --find-links=packages --no-build-isolation wiz-env

echo ""
echo "[✓] Wiz CLI installed successfully."
echo -n "[✓] Wiz CLI version: "
wiz --version
echo ""
echo "To reactivate this environment later, run: source env/bin/activate"
