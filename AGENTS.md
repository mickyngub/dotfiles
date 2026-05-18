# Dotfiles

Personal dotfiles for macOS and Linux — zsh, Neovim, tmux, yabai, skhd.

## Layout

- `.zshrc`, `.zsh_env_vars` — shell config (oh-my-zsh + Powerlevel10k)
- `.config/` — nvim, tmux, yabai (macOS), skhd (macOS), herdr (only `config.toml` tracked; rest gitignored)
- `init.sh` — one-shot setup script (installs brew packages, oh-my-zsh, plugins, symlinks)
- `README.md` — full setup walkthrough and feature list

## How it works

`init.sh` symlinks files in this repo to their real homes:
- `~/dotfiles/.zshrc` → `~/.zshrc`
- `~/dotfiles/.config/nvim` → `~/.config/nvim`
- `~/dotfiles/.config/tmux` → `~/.config/tmux`
- `~/dotfiles/.config/herdr` → `~/.config/herdr`
- `~/dotfiles/.zsh_env_vars` → `~/.zsh_env_vars`
- (macOS only) `.config/yabai`, `.config/skhd` → `~/.config/{yabai,skhd}`

It also installs Homebrew (+ packages), oh-my-zsh + Powerlevel10k, zsh plugins, TPM, **nvm + Node.js LTS**, and **Neovim 0.10.1 via `bob`** (pinned — bump `NVIM_VERSION` in `init.sh` to upgrade).

## Commands

- `./init.sh` — fresh install / re-run after pulling changes
- `cp .zsh_env_vars.example .zsh_env_vars` — seed local secrets file (gitignored)

## Footguns

- **`.zsh_env_vars` is gitignored** and holds secrets. Never commit it. The `.example` file is the safe template.
- **`init.sh` is idempotent but slow** (installs Homebrew packages). Don't run it just to pick up a config tweak — usually `source ~/.zshrc` or restarting the relevant program is enough.
- Edits to files in this repo affect the user's live shell/editor as soon as they're saved (these are the real config files, not copies).

See `README.md` for the full walkthrough.
