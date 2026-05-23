#!/usr/bin/env bash
set -e

echo "==================================="
echo " Language Learning Assistant Setup"
echo "==================================="
echo ""

# Check Python
if command -v python3 &>/dev/null; then
    PYTHON=python3
elif command -v python &>/dev/null; then
    PYTHON=python
else
    echo "Error: Python not found. Please install Python 3.8+ first."
    echo "  https://www.python.org/downloads/"
    exit 1
fi

PY_VERSION=$($PYTHON --version 2>&1)
echo "Found: $PY_VERSION"

# Install dependencies
echo ""
echo "Installing dependencies..."
$PYTHON -m pip install --upgrade pip -q
$PYTHON -m pip install -r requirements.txt -q
echo "Dependencies installed."

# Create directory structure
echo ""
echo "Creating directories..."
mkdir -p materials/input
mkdir -p materials/chapters
echo "Directory structure ready."

# Done
echo ""
echo "==================================="
echo " Setup complete!"
echo "==================================="
echo ""
echo "Next steps:"
echo "  1. Place your learning materials in materials/input/"
echo "  2. Open Claude Code and run /process-material"
echo "  3. Then run /learn-language to start learning"
echo ""
