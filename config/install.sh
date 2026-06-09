#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_MODE="${1:-${DOTFILES_INSTALL_MODE:-copy}}"

if [[ -d /opt/homebrew/bin ]]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
elif [[ -d /usr/local/bin ]]; then
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

require_command() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "Missing required command: $1" >&2
    exit 1
  fi
}

backup_existing() {
  local target="$1"
  if [[ -e "$target" || -L "$target" ]]; then
    local backup="${target}.bak.$(date +%s)"
    mv "$target" "$backup"
    echo "Backed up $target -> $backup"
  fi
}

deploy_file() {
  local source="$1"
  local target="$2"

  mkdir -p "$(dirname "$target")"

  case "$INSTALL_MODE" in
    copy)
      backup_existing "$target"
      cp "$source" "$target"
      ;;
    link)
      if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
        echo "Already linked: $target"
        return
      fi
      backup_existing "$target"
      ln -sfn "$source" "$target"
      ;;
    *)
      echo "Unsupported install mode: $INSTALL_MODE (expected: copy or link)" >&2
      exit 1
      ;;
  esac

  echo "Installed ($INSTALL_MODE): $target"
}

require_command brew

echo "==> Install mode: $INSTALL_MODE"
echo "==> Installing packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

echo "==> Deploying files..."
deploy_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
deploy_file "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
deploy_file "$DOTFILES_DIR/mise.toml" "$HOME/.config/mise/config.toml"
deploy_file "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
deploy_file "$DOTFILES_DIR/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"
deploy_file "$DOTFILES_DIR/starship.toml" "$HOME/.config/starship.toml"

if [[ "$(uname -s)" == "Darwin" ]]; then
  deploy_file "$DOTFILES_DIR/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
fi

echo "==> Local overrides"
echo "   See docs/local-overrides.md"

echo "==> Done"
