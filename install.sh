#!/bin/bash

echo "1. Updating system and installing basic dependencies..."
sudo apt-get update
# We need 'unzip' for Bob and 'curl' to get Bob
sudo apt-get install -y unzip curl ncurses-term wl-clipboard tree fd-find ripgrep fzf zoxide

echo "2. Setting up symlinks..."
DOTFILES_DIR="$HOME/dotfiles"
mkdir -p ~/.config
# Note: No need to mkdir nvim if we are symlinking the whole folder
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sfn "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

echo "3. Installing Bob & Neovim..."
if ! command -v bob &> /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash
fi

# Add Bob to the path for THIS script session
export PATH="$HOME/.local/share/bob/bin:$PATH"

echo "4. Finalizing shell..."
# Add paths to .zshrc so they persist in future sessions
{
    echo 'export PATH="$HOME/.local/share/bob/bin:$PATH"'
    echo 'export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"'
    echo 'export TERM=xterm-256color'
} >> "$HOME/.zshrc"

# Set ZSH as default
if [[ "$SHELL" != "/bin/zsh" ]]; then
    sudo chsh -s /bin/zsh $(whoami)
fi

zsh
# Use Bob to install and use nightly
bob use nightly

echo "Setup complete! Restart your shell or run 'zsh'."
