#!/bin/bash

echo "Setting up dotfiles..."

mkdir -p ~/.config/nvim
DOTFILES_DIR="$HOME/dotfiles"
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

echo "Setting up NVIM..."
# 1. Install Bob from Arch Extra
sudo apt-get -y bob
# 2. Use Bob to install and use the nightly version
bob use nightly
ln -s /root/.local/share/bob/nvim-bin/nvim /usr/local/bin/nvim

echo "Setting up shell to ZSH..."
if [[ "$SHELL" != "/bin/zsh" ]]; then
chsh -s /bin/zsh
else
echo "Zsh already set as default shell."
fi

export TERM=xterm-256color
