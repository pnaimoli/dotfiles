#!/bin/bash
ln -snf ~/.dotfiles/Rprofile ~/.Rprofile
ln -snf ~/.dotfiles/tmux.conf ~/.tmux.conf

ln -s ~/.dotfiles/zshrc ~/.zshrc

# link version controlled config directories, link nvim
for d in ~/.dotfiles/config/*; do [ -d "$d" ] && ln -snf "$d" ~/.config/"$(basename "$d")"; done
