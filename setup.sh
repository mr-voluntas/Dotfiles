#!/bin/bash

echo "Setting up dotfiles..."

mkdir -p ~/.config/nvim

DOTFILES_DIR="$HOME/dotfiles"

mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/.git" "$HOME/.git"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
