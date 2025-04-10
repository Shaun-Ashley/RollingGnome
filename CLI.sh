#!/bin/bash
# Offline Install Script for Wiz CLI on Primary Device (M1 Mac, macOS Sequoia)
# This script installs Wiz CLI using only the local packages.
# Run this script from within the unzipped folder (e.g., "wizcli-offline-setup").
set -euo pipefail

# Change to the directory where this script resides.
cd "$(dirname "$0")"

echo "[*] Starting Wiz CLI offline installation..."

# Check that the required wheels exist by testing for both possible wiz‑env naming patterns.
REQUIRED_WHEEL_PATTERNS=("wiz_env-*.whl" "wiz-env-*.whl" "ujson-*.whl" "setuptools-*.whl" "wheel-*.whl")
for pattern in "${REQUIRED_WHEEL_PATTERNS[@]}"; do
    if ! ls packages/$pattern >/dev/null 2>&1; then
        echo "[✗] ERROR: Missing required wheel matching pattern: $pattern"
        exit 1
    fi
done

echo "[*] All required wheels were found in the 'packages' directory."

echo "[*] Creating Python virtual environment..."
python3 -m venv env
source env/bin/activate

echo "[*] Installing offline tools (setuptools and wheel) from local packages..."
pip install --no-index --find-links=packages setuptools wheel

echo "[*] Installing wiz-env from offline packages..."
# The --no-build-isolation flag forces pip to use the already installed setuptools.
pip install --no-index --find-links=packages --no-build-isolation wiz-env

echo ""
echo "[✓] Wiz CLI installed successfully."
echo -n "[✓] Wiz CLI version: "
wiz --version
echo ""
echo "To reactivate this environment later, run: source env/bin/activate"
