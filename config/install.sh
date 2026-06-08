#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

link_file() {
  local source="$1"
  local target="$2"
  mkdir -p "$(dirname "$target")"
  ln -sfn "$source" "$target"
}

require_command brew

echo "==> Installing packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "==> Linking files..."
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/mise.toml" "$HOME/.config/mise/config.toml"
link_file "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
link_file "$DOTFILES_DIR/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

echo "==> Optional local files"
echo "   cp $DOTFILES_DIR/.gitconfig.local.example ~/.gitconfig.local"
echo "   cp $DOTFILES_DIR/.zshrc.local.example ~/.zshrc.local"

echo "==> Done"
