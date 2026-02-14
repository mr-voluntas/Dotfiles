# --- 1. Path & Environment ---
# Ensure Bob's Neovim and local bins are prioritized
export PATH="$HOME/.local/bin:$HOME/.local/share/bob/nvim-bin:$PATH"
export TERM=xterm-256color
export EDITOR="nvim"

# --- 2. Starship Auto-Installer ---
# If starship isn't found, it installs it silently on startup
if ! command -v starship &> /dev/null; then
    echo "🚀 Installing Starship prompt..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y > /dev/null
fi
eval "$(starship init bash)"

# --- 3. Aliases ---
alias ls='ls --color=auto'
alias v='nvim'

# --- 4. FZF & Zoxide ---
# We wrap these in 'if' checks so your bashrc doesn't error out 
# if you're on a machine where they aren't installed yet.
if command -v fzf &> /dev/null; then eval "$(fzf --bash)"; fi
if command -v zoxide &> /dev/null; then eval "$(zoxide init --cmd cd bash)"; fi

# --- 5. Better History Management ---
# Bash doesn't append history by default; it overwrites. Let's fix that.
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend          # Append to history, don't overwrite
PROMPT_COMMAND="history -a;$PROMPT_COMMAND" # Save history after every command

# --- 6. Completion Fixes ---
# This makes bash ignore case when tab-completing files (like Zsh)
bind "set completion-ignore-case on"
# This makes tab-completion show all matches on the first tab hit
bind "set show-all-if-ambiguous on"
