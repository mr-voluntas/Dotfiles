#!/bin/bash

echo "Checking internet connection..."
if ! ping -c 1 archlinux.org &>/dev/null; then
echo "No internet connection. Exiting."
exit 1
fi

echo "[1/5] Updating system..."
sudo pacman -Syu --noconfirm

echo "[2/5] Installing packages..."
sudo pacman -S --noconfirm \
    kitty hyprland firefox \
    zsh git docker zoxide \
    wl-clipboard ripgrep fzf fd tree man-db \
    unzip cmake make wget \

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
ln -sf ~/Dotfiles/.zshrc ~/.zshrc
ln -sf ~/Dotfiles/.zprofile ~/.zprofile
ln -sf ~/Dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/Dotfiles/.config/hypr ~/.config/hypr
ln -sf ~/Dotfiles/.config/kitty ~/.config/kitty
ln -sf ~/Dotfiles/.config/nvim ~/.config/nvim

echo "Setup complete..."
hyprctl dispatch exit
