# Micky's Dotfiles

Personal dotfiles for macOS and Linux, featuring Neovim, tmux, zsh (with oh-my-zsh + Powerlevel10k), yabai, and skhd.

## What's Included

- **zsh** — Shell config with oh-my-zsh, Powerlevel10k theme, zsh-autosuggestions, zsh-syntax-highlighting
- **Neovim** — Custom config with lazy.nvim
- **tmux** — Prefix remapped to `Ctrl+a`, vim-style copy mode, TPM plugins
- **yabai** — Tiling window manager (macOS only)
- **skhd** — Hotkey daemon (macOS only)
- **tmux session auto-color** — each session's status bar gets a unique color derived from its name (`tmux-session-color.sh`)
- **tmux zoom indicator** — when a pane is zoomed, the status bar turns yellow, the border shows a `▼ ZOOM ▼` label, and the terminal background tints via OSC 11 (`tmux-zoom-indicator.sh`)

## Setup

```sh
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./init.sh
```

That's it. The init script handles everything:

- Installs Homebrew (if needed) and all packages via brew on both macOS and Linux
- macOS extras: yabai, skhd
- Linux extras: build tools via system package manager (for Homebrew compatibility)
- Installs oh-my-zsh, Powerlevel10k, zsh plugins, TPM, nvm + Node.js LTS, and creates all symlinks

After setup, open a new terminal and:
- Press `Ctrl+a` then `Shift+I` inside tmux to install tmux plugins
- Run `p10k configure` to set up your prompt

## Environment Variables

Copy the example file and fill in your keys:

```sh
cp .zsh_env_vars.example .zsh_env_vars
```

This file is gitignored.

## Notes

- Remap Caps Lock to Control for a better tmux/vim experience

## References

- https://github.com/josean-dev/dev-environment-files
- https://github.com/ThePrimeagen/init.lua
- https://github.com/alpha2phi/neovim-for-beginner
