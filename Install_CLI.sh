#!/bin/bash

# Exit immediately if any command fails
set -e

echo ""
echo "============================================================"
echo "[ Wiz CLI Offline Installer – Apple Silicon Compatible ]"
echo "============================================================"
echo ""

# ------------------------------------------------------------
# STEP 1: Unzip the package (if it hasn't already been unpacked)
# ------------------------------------------------------------
if [ ! -d "wizcli-offline-setup" ]; then
    echo "[*] Unzipping 'wizcli_offline.zip'..."
    unzip wizcli_offline.zip
    echo "[✓] Unzipped successfully."
else
    echo "[*] Setup folder already exists. Skipping unzip."
fi

cd wizcli-offline-setup

# ------------------------------------------------------------
# STEP 2: Validate presence of essential packages
# ------------------------------------------------------------
echo "[*] Validating required files..."

# Confirm a compatible ujson wheel is present (critical)
if ! ls packages/ujson-*-macosx_11_0_arm64.whl >/dev/null 2>&1; then
    echo "[✗] ERROR: Compatible ujson wheel (Apple Silicon) not found in 'packages/'."
    echo "    Please re-run the Device 2 prep script with the correct platform/Python wheel."
    exit 1
else
    echo "[✓] Compatible ujson wheel found."
fi

# ------------------------------------------------------------
# STEP 3: Create and activate a new virtual environment
# ------------------------------------------------------------
echo "[*] Creating Python virtual environment..."
python3 -m venv env

echo "[*] Activating virtual environment..."
source env/bin/activate

# ------------------------------------------------------------
# STEP 4: Install build tools from local packages (setuptools + wheel)
# ------------------------------------------------------------
echo "[*] Installing setuptools and wheel from local files..."
pip install --no-index --find-links=packages "setuptools>=48.8.0" wheel

# ------------------------------------------------------------
# STEP 5: Install Wiz CLI from local packages, using no-build-isolation
# ------------------------------------------------------------
echo "[*] Installing Wiz CLI (wiz-env) from local packages..."
pip install --no-index --find-links=packages --no-build-isolation wiz-env

# ------------------------------------------------------------
# STEP 6: Verify installation
# ------------------------------------------------------------
echo ""
echo "[✓] Installation complete!"
echo -n "[✓] Wiz CLI version: "
wiz --version

echo ""
echo "============================================================"
echo "[ Done! To activate the environment later, run: ]"
echo "  source wizcli-offline-setup/env/bin/activate"
echo ""
echo "[ You can now use the 'wiz' command inside the environment. ]"
echo "============================================================"
