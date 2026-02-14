# --- Path & Environment ---
export PATH="$HOME/.local/share/bob/bin:$HOME/.local/share/bob/nvim-bin:$HOME/.config/emacs/bin:$PATH"
export TERM=xterm-256color

# --- Starship Prompt ---
# This replaces the entire "Prompt" and "VCS_info" block
eval "$(starship init bash)"

# --- Aliases ---
alias ls='ls --color=auto'
alias ll='ls -lah'

# --- FZF & Zoxide ---
# These work perfectly in Bash
eval "$(fzf --bash)"
eval "$(zoxide init --cmd cd bash)"

# --- Basic History ---
HISTSIZE=5000
HISTFILE=~/.bash_history
SAVEHIST=$HISTSIZE
shopt -s histappend
