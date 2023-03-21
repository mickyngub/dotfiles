# Micky's Dev Environment Configuration✨

1. Install brew

   `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

   `echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/[username]/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"`

2. Install iTerm2, oh-my-zsh, powerlevel10k, git

   `brew install --cask iterm2`

   `brew install git`

   `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

   `git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k`

3. Configure iTerm2 with blue-matrix.itermcolors color preset

4. Install zsh plugins

   `git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`

   `git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

5. Install nvim, tmux, yabai, skhd, and ripgrep

   `brew install nvim`

   `brew install tmux`

   `brew install koekeishiya/formulae/yabai`

   `brew install koekeishiya/formulae/skhd`

   `brew install ripgrep`

6. Run `zsh init.sh`

7. git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

8. Open tmux and `Crtl + a + Shift + i` to install tmux plugins

## Notes

    - remap caps lock to control
    - set `Close` shortcut for iTerm2 to `Command + Shift + w`
    - set iTerm2 to be able to use option key to jump back and forth

## References

- https://github.com/josean-dev/dev-environment-files
- https://github.com/ThePrimeagen/init.lua
- https://github.com/alpha2phi/neovim-for-beginner
- https://jonnyhaynes.medium.com/jump-forwards-backwards-and-delete-a-word-in-iterm2-on-mac-os-43821511f0a
