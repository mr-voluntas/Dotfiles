#!/bin/bash
set -e # Exit on error - good practice for base scripts

echo "1. Updating system and installing dependencies..."
sudo apt-get update
sudo apt-get install -y unzip curl ncurses-term wl-clipboard tree fd-find ripgrep fzf zoxide

echo "2. Setting up symlinks..."
DOTFILES_DIR="$HOME/dotfiles"
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"
ln -sfn "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

echo "3. Installing Bob & Neovim..."
if [ ! -d "$HOME/.local/share/bob" ]; then
    curl -fsSL https://raw.githubusercontent.com/MordechaiHadad/bob/master/scripts/install.sh | bash
fi

# Update PATH for the REMAINDER of this script
export PATH="$HOME/.local/share/bob/bin:$PATH"

# Now bob is available to this script
bob use nightly

echo "4. Finalizing shell..."
# Use the "check before append" trick so you don't double-up on rebuilds
if ! grep -q "bob/bin" "$HOME/.zshrc"; then
    {
        echo 'export PATH="$HOME/.local/share/bob/bin:$PATH"'
        echo 'export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"'
        echo 'export TERM=xterm-256color'
    } >> "$HOME/.zshrc"
fi

# Set ZSH as default
if [[ "$SHELL" != "/bin/zsh" ]]; then
    sudo chsh -s /bin/zsh $(whoami)
fi

echo "Setup complete!"
