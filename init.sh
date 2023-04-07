#!/usr/bin/zsh 

# deletes the existing file/directory before running this file

# Create symlink for config files
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/yabai ~/.config/yabai
ln -s ~/dotfiles/skhd ~/.config/skhd
ln -s ~/dotfiles/.zsh_env_vars ~/.zsh_env_vars

