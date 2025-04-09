#!/bin/bash

set -euo pipefail

echo ""
echo "===================================================="
echo " Wiz CLI Offline Installer for Python 3.12 – macOS ARM64"
echo "===================================================="
echo ""

# === STEP 1: Unzip if needed ===
if [ ! -d "wizcli-offline-setup" ]; then
    echo "[*] Unzipping wizcli_offline.zip..."
    unzip wizcli_offline.zip
    echo "[✓] Unzipped successfully."
else
    echo "[*] 'wizcli-offline-setup' already exists. Skipping unzip."
fi

cd wizcli-offline-setup

# === STEP 2: Verify critical wheels exist ===
echo "[*] Verifying expected packages..."

REQUIRED_WHEELS=(
    "wiz_env-.*\.whl"
    "ujson-.*-macosx_11_0_arm64\.whl"
    "setuptools-.*\.whl"
    "wheel-.*\.whl"
)

for pattern in "${REQUIRED_WHEELS[@]}"; do
    if ! ls packages/"$pattern" >/dev/null 2>&1; then
        echo "[✗] ERROR: Missing required wheel: $pattern"
        exit 1
    fi
done

# === STEP 3: Create and activate virtual environment ===
echo "[*] Creating Python virtual environment..."
python3 -m venv env
source env/bin/activate

# === STEP 4: Install build tools from offline wheel files ===
echo "[*] Installing setuptools and wheel from local packages..."
pip install --no-index --find-links=packages setuptools wheel

# === STEP 5: Install wiz-env (Wiz CLI) and dependencies ===
echo "[*] Installing wiz-env from offline packages..."
pip install --no-index --find-links=packages --no-build-isolation wiz-env

# === STEP 6: Confirm success ===
echo ""
echo "[✓] Wiz CLI installed successfully!"
echo -n "[✓] Version: "
wiz --version

echo ""
echo "===================================================="
echo " All done! To activate this environment later, run:"
echo "   source wizcli-offline-setup/env/bin/activate"
echo ""
echo " You can now use the 'wiz' command inside the venv."
echo "===================================================="
