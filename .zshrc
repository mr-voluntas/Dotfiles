# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

export PATH="$HOME/.config/emacs/bin:$HOME/go/bin:$PATH"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit ice depth=1

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Nord fzf theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#4C566A,bg:#2E3440,spinner:#ECEFF4,hl:#81A1C1 \
--color=fg:#D8DEE9,header:#81A1C1,info:#88C0D0,pointer:#ECEFF4 \
--color=marker:#8FBCBB,fg+:#D8DEE9,prompt:#88C0D0,hl+:#81A1C1 \
--color=selected-bg:#3B4252 \
--color=border:#4C566A,label:#D8DEE9"

# Aliases
alias ls='ls --color'
alias v='nvim'
alias c='clear'
alias battery="echo $(cat /sys/class/power_supply/BAT0/capacity)%"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
