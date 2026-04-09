#!/usr/bin/env bash
set -e

echo "==> Starting dotfiles setup..."

# ─── Install Homebrew ───
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ "$(uname)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# ─── Install brew packages ───
echo "==> Installing brew packages..."
brew install git neovim tmux ripgrep fd fzf gnu-sed zoxide curl unzip zsh 2>/dev/null || true

if [[ "$(uname)" == "Darwin" ]]; then
  brew install koekeishiya/formulae/yabai koekeishiya/formulae/skhd 2>/dev/null || true
  brew install --cask iterm2 2>/dev/null || true
fi

# ─── Linux: install build tools needed by Homebrew ───
if [[ "$(uname)" == "Linux" ]]; then
  if command -v apt &>/dev/null; then
    sudo apt update && sudo apt install -y build-essential
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y gcc gcc-c++ make
  elif command -v pacman &>/dev/null; then
    sudo pacman -Sy --noconfirm base-devel
  fi
fi

# ─── oh-my-zsh ───
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "==> Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ─── Powerlevel10k ───
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]]; then
  echo "==> Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# ─── zsh plugins ───
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
  echo "==> Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
  echo "==> Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# ─── TPM (tmux plugin manager) ───
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
  echo "==> Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# ─── nvm + Node.js ───
export NVM_DIR="$HOME/.nvm"
if [[ ! -d "$NVM_DIR" ]]; then
  echo "==> Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm install --lts
fi

# ─── Symlinks ───
echo "==> Creating symlinks..."
mkdir -p ~/.config

ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.zsh_env_vars ~/.zsh_env_vars

if [[ "$(uname)" == "Darwin" ]]; then
  ln -sf ~/dotfiles/yabai ~/.config/yabai
  ln -sf ~/dotfiles/skhd ~/.config/skhd
fi

# ─── Set default shell to zsh ───
if [[ "$SHELL" != *"zsh"* ]]; then
  echo "==> Changing default shell to zsh..."
  chsh -s "$(which zsh)"
fi

# ─── Environment variables template ───
if [[ ! -f ~/dotfiles/.zsh_env_vars ]]; then
  echo "==> Creating .zsh_env_vars from example..."
  cp ~/dotfiles/.zsh_env_vars.example ~/dotfiles/.zsh_env_vars
fi

echo ""
echo "==> Done! Open a new terminal to start using your dotfiles."
echo "    - In tmux, press Ctrl+a then Shift+I to install tmux plugins."
echo "    - Run 'p10k configure' to set up your Powerlevel10k prompt."
