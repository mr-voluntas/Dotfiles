#!/bin/bash
set -e 

echo "1. System Updates & Dependencies..."
sudo apt-get update
sudo apt-get install -y unzip curl ncurses-term wl-clipboard tree fd-find ripgrep fzf zoxide

echo "2. Setting up symlinks..."
DOTFILES_DIR="$HOME/dotfiles"
mkdir -p ~/.config
# We use -f to overwrite any existing default Ubuntu bashrc
ln -sf "$DOTFILES_DIR/.bashrc" "$HOME/.bashrc"
ln -sfn "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
ln -sf "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

echo "3. Installing Bob & Neovim..."
if [ ! -d "$HOME/.local/share/bob" ]; then
    curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash
fi

# Update PATH for the REMAINDER of this script session
export PATH="$HOME/.local/share/bob/bin:$HOME/.local/share/bob/nvim-bin:$PATH"

# Install Neovim Nightly
bob use nightly

