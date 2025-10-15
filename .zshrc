export PATH="$HOME/.config/emacs/bin:$PATH"
export DOOMDIR="$HOME/.config/doom"

# -----------------------------
# Zinit & Plugins
# -----------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install Zinit if missing
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Load plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab
zinit snippet OMZP::git

autoload -Uz compinit && compinit

# -----------------------------
# Prompt
# -----------------------------
autoload -Uz vcs_info
setopt prompt_subst

# Update prompt function
update_prompt() {
  precmd() { vcs_info }
  zstyle ':vcs_info:git:*' formats '%F{cyan}(%b)%f'
  PROMPT='%F{green}%~%f ${vcs_info_msg_0_}: '
}

# Initialize prompt immediately
update_prompt

# -----------------------------
# Keybindings
# -----------------------------
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# -----------------------------
# History
# -----------------------------
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_save_no_dups hist_ignore_dups hist_find_no_dups

# -----------------------------
# Aliases
# -----------------------------
alias ls='ls --color'
alias sleep='systemctl suspend'
alias dooms='pkill -f "emacs --daemon" && doom sync && emacs --daemon'

# -----------------------------
# FZF & Zoxide
# -----------------------------
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

