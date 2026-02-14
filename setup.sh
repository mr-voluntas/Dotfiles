#!/bin/bash

echo "[1/5] Updating system..."
pacman -Syu --noconfirm

echo "[2/5] Installing packages..."
pacman -S --noconfirm \
    zsh git zoxide \
    wl-clipboard ripgrep \
    fzf fd tree man-db ncurses kitty-terminfo\

echo "[3/5] Installing NVIM 0.12..."
# 1. Install dependencies
pacman -S --noconfirm curl tar fuse2
# 2. Download with -L to follow redirects
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
# 3. Extract and move to /usr/local
tar -C /usr/local --strip-components 1 -xzf nvim-linux64.tar.gz
# 4. Cleanup
rm nvim-linux64.tar.gz

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
