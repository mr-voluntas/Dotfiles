#!/bin/bash

echo "[1/5] Updating system..."
sudo pacman -Syu --noconfirm

echo "[2/5] Installing packages..."
sudo pacman -S --noconfirm \
    zsh git zoxide \
    wl-clipboard ripgrep \
    fzf fd tree man-db \

echo "[3/5] Setting default shell to zsh..."
if [[ "$SHELL" != "/bin/zsh" ]]; then
chsh -s /bin/zsh
else
echo "Zsh already set as default shell."
fi

echo "[4/5] Installing fonts..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
mkdir -p ~/.local/share/fonts/JetBrainsMonoNF
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNF
rm -rf JetBrainsMono.zip
fc-cache -fv

echo "[5/5] Setting up dotfiles..."
ln -sf .zshrc ~/.zshrc
ln -sf .zprofile ~/.zprofile
ln -sf .gitconfig ~/.gitconfig
ln -sf .config/nvim ~/.config/nvim
