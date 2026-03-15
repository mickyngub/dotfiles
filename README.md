# Micky's Dotfiles

Personal dotfiles for macOS and Linux, featuring Neovim, tmux, zsh (with oh-my-zsh + Powerlevel10k), yabai, and skhd.

## What's Included

- **zsh** — Shell config with oh-my-zsh, Powerlevel10k theme, zsh-autosuggestions, zsh-syntax-highlighting
- **Neovim** — Custom config with lazy.nvim
- **tmux** — Prefix remapped to `Ctrl+a`, vim-style copy mode, TPM plugins
- **yabai** — Tiling window manager (macOS only)
- **skhd** — Hotkey daemon (macOS only)
- **iTerm2 color presets** — blue-matrix, kanagawa, kanagawa_dragon, tokyo-night

## Setup

```sh
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
zsh init.sh
```

That's it. The init script handles everything:

- Installs Homebrew (if needed) and all packages via brew on both macOS and Linux
- macOS extras: iTerm2, yabai, skhd
- Linux extras: build tools via system package manager (for Homebrew compatibility)
- Installs oh-my-zsh, Powerlevel10k, zsh plugins, TPM, nvm + Node.js LTS, and creates all symlinks

After setup, open a new terminal and:
- Press `Ctrl+a` then `Shift+I` inside tmux to install tmux plugins
- Run `p10k configure` to set up your prompt
- (macOS) Import an iTerm2 color preset from this repo (e.g. `kanagawa.itermcolors`)

## Environment Variables

Copy the example file and fill in your keys:

```sh
cp .zsh_env_vars.example .zsh_env_vars
```

This file is gitignored.

## Notes

- Remap Caps Lock to Control for a better tmux/vim experience
- On iTerm2, set the Close shortcut to `Cmd+Shift+W`
- On iTerm2, configure the Option key to send Esc+ for word-jumping shortcuts

## References

- https://github.com/josean-dev/dev-environment-files
- https://github.com/ThePrimeagen/init.lua
- https://github.com/alpha2phi/neovim-for-beginner
- https://jonnyhaynes.medium.com/jump-forwards-backwards-and-delete-a-word-in-iterm2-on-mac-os-43821511f0a
