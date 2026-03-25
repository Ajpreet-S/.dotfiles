#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# ── Options ───────────────────────────────────────────────────────────────────
shopt -s autocd
shopt -s histappend
HISTSIZE=2000
HISTFILESIZE=4000

# ── PATH ──────────────────────────────────────────────────────────────────────
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.local/share/JetBrains/Toolbox/scripts"

# ── Environment ───────────────────────────────────────────────────────────────
for f in ~/.config/shell/envs/*.sh; do source "$f"; done

# ── Aliases ───────────────────────────────────────────────────────────────────
source ~/.config/shell/aliases.sh

# ── Functions ─────────────────────────────────────────────────────────────────
source ~/.config/shell/functions.sh


# ── Tools ─────────────────────────────────────────────────────────────────────
source /usr/share/nvm/init-nvm.sh
eval "$(zoxide init bash)"
