#!/bin/bash
set -e

# Polyfill sudo if not present (e.g. running as root in container)
if ! command -v sudo >/dev/null 2>&1; then
  sudo() {
    "$@"
  }
fi

# Logger
log() {
  echo -e "\033[1;32m[Dotfiles]\033[0m $1"
}

error() {
  echo -e "\033[1;31m[Dotfiles Error]\033[0m $1"
}

# 1. Config Files Association

USER_HOME=${HOME}
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

log "Linking configuration files from $DOTFILES_DIR..."

# Symlink .zshrc
if [ -f "$DOTFILES_DIR/.zshrc" ]; then
  rm -f "$USER_HOME/.zshrc"
  ln -s "$DOTFILES_DIR/.zshrc" "$USER_HOME/.zshrc"
  log "Linked .zshrc"
fi

# 2. Core Utilities

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

# Update package lists if we are going to install apt packages
if [ -f "/etc/debian_version" ]; then
  log "Updating apt..."
  sudo apt-get update
fi

# Install Zsh
if ! has_cmd zsh; then
  log "Installing Zsh..."
  sudo apt-get install -y zsh
fi

# Install eza
if ! has_cmd eza; then
  log "Installing eza..."
  # Prerequisites
  sudo apt-get install -y gpg wget
  sudo mkdir -p /etc/apt/keyrings
  if [ ! -f /etc/apt/keyrings/gierens.gpg ]; then
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  fi
  echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  sudo apt-get update && sudo apt-get install -y eza
fi

# Install Oh My Posh
if ! has_cmd oh-my-posh; then
  log "Installing Oh My Posh..."
  curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin
fi

# Setup Montys theme
log "Setting up Montys theme..."
mkdir -p "$USER_HOME/.poshthemes"
curl -sLo "$USER_HOME/.poshthemes/montys.omp.json" https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/montys.omp.json

# 3. Specific Utilities

# Google Antigravity CLI
if ! has_cmd antigravity; then
  log "Installing Google Antigravity CLI..."
  curl -fsSL https://antigravity.google/cli/install.sh | bash
fi

log "Dotfiles installation complete!"
