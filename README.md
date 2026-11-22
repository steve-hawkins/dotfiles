# Devcontainer Dotfiles

This directory contains configuration files and an installation script to set up your personal development environment across devcontainers.

## Contents

- **install.sh**: The main entry point. Installs utilities (`zsh`, `eza`, `xclip`, Oh My Posh, Hack Nerd Font, Antigravity CLI) and links configuration files.
- **.zshrc**: Configuration for Zsh, including Oh My Posh (Montys theme) and `eza` aliases.

## Terminal Icons (Nerd Font)

Oh My Posh and `eza --icons` require a Nerd Font to render icons properly. `install.sh` installs **Hack Nerd Font** inside the container, and `.devcontainer/devcontainer.json` sets `"terminal.integrated.fontFamily": "Hack Nerd Font"` for this repo.

Because VS Code renders terminal fonts on your **host machine**, make sure **Hack Nerd Font** is also installed on your host OS and configured in your VS Code **User Settings**:

```json
"terminal.integrated.fontFamily": "Hack Nerd Font"
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
