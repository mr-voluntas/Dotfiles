#!/bin/bash

echo "Checking internet connection..."
if ! ping -c 1 archlinux.org &>/dev/null; then
echo "No internet connection. Exiting."
exit 1
fi

echo "[1/6] Updating system..."
sudo pacman -Syu --noconfirm

echo "[2/6] Installing packages..."
sudo pacman -S --noconfirm \
    kitty hyprland emacs-wayland firefox \
    zsh git docker zoxide \
    wl-clipboard ripgrep fzf fd tree man-db \
    unzip cmake make wget \

echo "[3/6] Installing doom emacs..."
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install

echo "[4/6] Setting default shell to zsh..."
if [[ "$SHELL" != "/bin/zsh" ]]; then
chsh -s /bin/zsh
else
echo "Zsh already set as default shell."
fi

echo "[5/6] Installing fonts..."
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
mkdir -p ~/.local/share/fonts/JetBrainsMonoNF
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNF
rm -rf JetBrainsMono.zip
fc-cache -fv

echo "[6/6] Setting up dotfiles..."
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.zprofile ~/.zprofile
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.config/hypr ~/.config
ln -sf ~/dotfiles/.config/kitty ~/.config
ln -sf ~/dotfiles/.config/doom ~/.config
ln -sf ~/dotfiles/.config/nvim ~/.config

echo "Setup complete..."
hyprctl dispatch exit
