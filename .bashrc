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
export AWS_PROFILE=optic


# ── Aliases ───────────────────────────────────────────────────────────────────
alias ls='ls --color=auto'
alias l='eza -l'
alias la='eza -la'
alias lt='eza -l --tree --level=2'

alias grep='grep --color=auto'
alias c=cd
alias v=nvim
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles.git/" --work-tree="$HOME"'


# ── Functions ─────────────────────────────────────────────────────────────────
cl() {
    cd "$1" && ls
}

zz() {
    z "$1" && eza
}

# Docker container shell shortcut
# Usage: dsh <alias>  e.g. dsh lavp
dsh() {
    declare -A containers=(
        [modp]="optic_modx_php"
        [modn]="optic_modx_nginx"
        [lavp]="optic_laravel_php"
        [lavn]="optic_laravel_nginx"
    )

    local name="${containers[$1]}"
    if [ -z "$name" ]; then
        echo "Unknown alias '$1'. Available: ${!containers[*]}"
        return 1
    fi

    docker exec -it "$name" bash 2>/dev/null || docker exec -it "$name" sh
}

# Quick config file opener
# Usage: config  then press key
config() {
    declare -A configs=(
        [b]="$HOME/.bashrc"
        [v]="$HOME/.config/nvim/init.vim"
        [h]="$HOME/.config/hypr/hyprland.conf"
        [w]="$HOME/.config/waybar/"
        [t]="$HOME/.config/kitty/kitty.conf"
    )

    echo "Select config:"
    echo "  [b] .bashrc"
    echo "  [v] Vim"
    echo "  [h] Hyprland"
    echo "  [w] Waybar"
    echo "  [t] Terminal"

    read -rsn1 key

    if [[ "$key" == "q" || -z "$key" ]]; then
        return
    fi

    if [[ -n "${configs[$key]}" ]]; then
        vim "${configs[$key]}"
    else
        echo "Invalid key: $key"
    fi
}


# ── Tools ─────────────────────────────────────────────────────────────────────
source /usr/share/nvm/init-nvm.sh
eval "$(zoxide init bash)"
