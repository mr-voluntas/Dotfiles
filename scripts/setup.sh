#!/bin/bash

set -e

DOTFILES_REPO="git@github.com:mr-voluntas/dotfiles.git"

echo "Checking internet connection..."
if ! ping -c 1 archlinux.org &>/dev/null; then
echo "No internet connection. Exiting."
exit 1
fi

echo "[1/5] Updating system..."
sudo pacman -Syu --noconfirm

echo "[2/5] Installing packages..."
sudo pacman -S --noconfirm \
    ttf-jetbrains-mono-nerd kitty hyprland \
    nvim openssh firefox wl-clipboard git \
    stow zsh ripgrep fzf zoxide starship \
    unzip luarocks cmake make wget \
    tree-sitter fd man-db tree pavucontrol \
    tmux

echo "[3/5] Cloning dotfiles..."
chezmoi init "$DOTFILES_REPO"

echo "[4/5] Setting default shell to zsh..."
if [[ "$SHELL" != "/bin/zsh" ]]; then
chsh -s /bin/zsh
else
echo "Zsh already set as default shell."
fi

echo "[5/5] Installing fonts..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
mkdir -p ~/.local/share/fonts/JetBrainsMonoNF
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNF
rm -rf JetBrainsMono.zip
fc-cache -fv

echo "Setup complete. Reboot or re-login to apply shell changes."

