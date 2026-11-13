#!/usr/bin/env bash
set -euo pipefail

SWOP_URL="https://raw.githubusercontent.com/tedtasman/swop/main/swop"
BIN_DIR="$HOME/.local/bin"
TARGET="$BIN_DIR/swop"

mkdir -p "$BIN_DIR"
curl -fsSL "$SWOP_URL" -o "$TARGET"
chmod 755 "$TARGET"
printf 'swop installed at %s\n' "$TARGET"

# add ~/.local/bin to PATH if missing
if [[ ":$PATH:" != *":$BIN_DIR:"* ]] && ! grep -qF '.local/bin' "$HOME/.bashrc" 2>/dev/null; then
    cat >> "$HOME/.bashrc" <<'EOF'

# swop - add ~/.local/bin to PATH
case ":$PATH:" in
    *":$HOME/.local/bin:"*) ;;
    *) export PATH="$HOME/.local/bin:$PATH" ;;
esac
EOF
    printf '%s added to PATH in ~/.bashrc (applies to new shells)\n' "$BIN_DIR"
fi

