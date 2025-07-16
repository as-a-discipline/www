#!/usr/bin/env bash

set -x

# Usage: ./build.sh [DATA_DIR] [WEBSITE_DIR]
# Defaults: DATA_DIR="data", WEBSITE_DIR="_website/page-scribe-static-flow"

DATA_DIR="${1:-${DATA_DIR:-data}}"
WEBSITE_DIR="${2:-${WEBSITE_DIR:-_website/page-scribe-static-flow}}"
TOOLS_DIR="$WEBSITE_DIR/tools"

# Check for _website directory
if [ ! -d "$WEBSITE_DIR" ]; then
  echo "Error: Website directory '$WEBSITE_DIR' does not exist."
  exit 1
fi

# Check for data directory
if [ ! -d "$DATA_DIR" ]; then
  echo "Error: Data directory '$DATA_DIR' does not exist."
  exit 1
fi

# Run install.sh
if [ ! -x "$TOOLS_DIR/install.sh" ]; then
  echo "Error: install.sh not found or not executable in $TOOLS_DIR"
  exit 1
fi
"$TOOLS_DIR/install.sh"

# Run compile.sh
if [ ! -x "$TOOLS_DIR/compile.sh" ]; then
  echo "Error: compile.sh not found or not executable in $TOOLS_DIR"
  exit 1
fi
"$TOOLS_DIR/compile.sh" "$DATA_DIR" "$WEBSITE_DIR/src/data"

# Install npm dependencies and vite, then build
cd "$WEBSITE_DIR" || exit 1
npm install
npm install vite
npm run build