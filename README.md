# Devcontainer Dotfiles

This directory contains configuration files and an installation script to set up your personal development environment across devcontainers.

## Contents

- **install.sh**: The main entry point. Installs utilities (`zsh`, `eza`, `xclip`, Oh My Posh, Antigravity CLI) and links configuration files.
- **.zshrc**: Configuration for Zsh, including Oh My Posh (Montys theme) and `eza` aliases.

## Terminal Icons (Nerd Font)

Oh My Posh and `eza --icons` require a Nerd Font to render icons properly. Because VS Code renders terminal fonts on your **local host machine / browser** (not inside the remote Codespace container), fonts must be installed locally:

1. Install **Hack Nerd Font** on your local machine (e.g., from [nerdfonts.com](https://www.nerdfonts.com/font-downloads), `brew install --cask font-hack-nerd-font` on macOS, or `oh-my-posh font install Hack` locally).
2. Fully restart VS Code (or your browser if using Codespaces on the web).
3. Add the following to your VS Code **User Settings** (with **Settings Sync** enabled so it applies to all Codespaces):

```json
"terminal.integrated.fontFamily": "'Hack Nerd Font Mono', 'Hack Nerd Font', monospace"
```

## Usage

### Method 1: VS Code Dotfiles (Recommended)

1. Open VS Code Settings (`Ctrl+,`).
2. Search for "Dotfiles".
3. Set **Dotfiles: Repository** to `https://github.com/steve-hawkins/dotfiles`.
4. Set **Dotfiles: Install Command** to `install.sh`.
5. Set **Dotfiles: Target Path** to `~/dotfiles` (or your preferred path).

VS Code will automatically clone this repo and run `install.sh` when building a new devcontainer.

### Method 2: Manual / mounting

You can also mount this folder into your container and run `./install.sh` manually.
