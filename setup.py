#!/usr/bin/env python3
"""Cross-platform setup script for Language Learning Assistant."""

import subprocess
import sys
import os

def main():
    print("=" * 43)
    print(" Language Learning Assistant Setup")
    print("=" * 43)
    print()

    # Check Python version
    if sys.version_info < (3, 8):
        print(f"Error: Python 3.8+ required, found {sys.version}")
        print("  https://www.python.org/downloads/")
        sys.exit(1)

    print(f"Found: Python {sys.version.split()[0]}")

    # Install dependencies
    print()
    print("Installing dependencies...")
    subprocess.check_call(
        [sys.executable, "-m", "pip", "install", "--upgrade", "pip", "-q"],
        stdout=subprocess.DEVNULL,
    )
    subprocess.check_call(
        [sys.executable, "-m", "pip", "install", "-r", "requirements.txt", "-q"]
    )
    print("Dependencies installed.")

    # Create directory structure
    print()
    print("Creating directories...")
    os.makedirs(os.path.join("materials", "input"), exist_ok=True)
    os.makedirs(os.path.join("materials", "chapters"), exist_ok=True)
    print("Directory structure ready.")

    # Done
    print()
    print("=" * 43)
    print(" Setup complete!")
    print("=" * 43)
    print()
    print("Next steps:")
    print("  1. Place your learning materials in materials/input/")
    print("  2. Open Claude Code and run /process-material")
    print("  3. Then run /learn-language to start learning")
    print()

if __name__ == "__main__":
    main()
