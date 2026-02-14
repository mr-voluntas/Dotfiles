#!/bin/bash

echo "[1/4] Updating system..."
pacman -Syu --noconfirm

echo "[2/4] Installing packages..."
pacman -S --noconfirm \
    zsh git zoxide \
    wl-clipboard ripgrep \
    fzf fd tree man-db ncurses kitty-terminfo\

echo "[3/4] Installing NVIM..."
# Install dependencies needed for Neovim 0.12
pacman -S --noconfirm curl tar fuse
# Download the nightly AppImage (which is the 0.12 build)
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
# Extract it to /usr/local
tar -C /usr/local --strip-components 1 -xzf nvim-linux64.tar.gz
# Clean up
rm nvim-linux64.tar.gz 

echo "[4/4] Setting default shell to zsh..."
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
