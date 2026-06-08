#!/bin/zsh

# Homebrew
if [[ -d /opt/homebrew ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
    BREW_PREFIX="/opt/homebrew"
elif [[ -d /usr/local/Cellar ]]; then
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
    BREW_PREFIX="/usr/local"
fi

# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Mise
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

# Zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# Aliases
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first --git'
alias lt='eza -T --icons --level=2'
alias cat='bat --paging=never --style=plain'

# Plugins
[[ -n "${BREW_PREFIX:-}" && -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

[[ -n "${BREW_PREFIX:-}" && -d "$BREW_PREFIX/share/zsh-completions" ]] &&
    fpath=("$BREW_PREFIX/share/zsh-completions" $fpath)

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=*'

# History
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY INC_APPEND_HISTORY

# Arrow key history search
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Fastfetch
if [[ $- == *i* ]] && command -v fastfetch >/dev/null 2>&1; then
    if [[ -z "${SSH_CONNECTION:-}" && -z "${SSH_TTY:-}" ]]; then
        fastfetch
    fi
fi

# Local override
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Syntax highlighting
[[ -n "${BREW_PREFIX:-}" && -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] &&
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
