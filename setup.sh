#!/bin/bash

echo "[1/5] Updating system..."
pacman -Syu --noconfirm

echo "[2/5] Installing packages..."
pacman -S --noconfirm \
    zsh git zoxide \
    wl-clipboard ripgrep \
    fzf fd tree man-db ncurses kitty-terminfo\

echo "[3/5] Installing NVIM 0.12..."
# 1. Install Bob from Arch Extra
pacman -S --noconfirm bob
# 2. Use Bob to install and use the nightly version
bob use nightly
ln -s /root/.local/share/bob/nvim-bin/nvim /usr/local/bin/nvim

echo "[4/5] Setting default shell to zsh..."
if [[ "$SHELL" != "/bin/zsh" ]]; then
chsh -s /bin/zsh
else
echo "Zsh already set as default shell."
fi

echo "[5/5] Setting up dotfiles..."
# Use $HOME to ensure we are pointing to the right place
DOTFILES_DIR="$HOME/dotfiles"

mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
