#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_SCRIPT="$ROOT_DIR/config/install.sh"

if [[ ! -f "$INSTALL_SCRIPT" ]]; then
  echo "Missing install script: $INSTALL_SCRIPT" >&2
  echo "Please confirm the repository structure is complete, then run ./bootstrap.sh again." >&2
  exit 1
fi

bash "$INSTALL_SCRIPT"
