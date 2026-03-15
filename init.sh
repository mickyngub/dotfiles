#!/usr/bin/env bash

# deletes the existing file/directory before running this file

# Ensure ~/.config exists
mkdir -p ~/.config

# Create symlink for config files (cross-platform)
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.zsh_env_vars ~/.zsh_env_vars

# macOS-only setup
if [[ "$(uname)" == "Darwin" ]]; then
  ln -sf ~/dotfiles/yabai ~/.config/yabai
  ln -sf ~/dotfiles/skhd ~/.config/skhd
fi

# Linux: install common dependencies
if [[ "$(uname)" == "Linux" ]]; then
  echo "Installing dependencies for Linux..."
  if command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y git curl neovim tmux ripgrep fd-find fzf zsh zoxide zsh-autosuggestions zsh-syntax-highlighting build-essential unzip
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y git neovim tmux ripgrep fd-find fzf zsh zoxide zsh-autosuggestions zsh-syntax-highlighting gcc gcc-c++ make unzip
  elif command -v pacman &>/dev/null; then
    sudo pacman -Sy --noconfirm git neovim tmux ripgrep fd fzf zsh zoxide zsh-autosuggestions zsh-syntax-highlighting base-devel unzip
  else
    echo "Unsupported package manager. Install git, neovim, tmux, ripgrep, fd, fzf, zsh, zoxide, zsh-autosuggestions, and zsh-syntax-highlighting manually."
  fi

fi

# Install nvm and Node.js
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm install --lts
fi
