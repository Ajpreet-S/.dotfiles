# Quick config file opener
conf() {
    local options=(
        "s  .config/shell        $HOME/.config/shell"
        "v  neovim               $HOME/.config/nvim/init.vim"
        "h  hyprland             $HOME/.config/hypr/hyprland.conf"
        "w  waybar               $HOME/.config/waybar"
        "t  terminal             $HOME/.config/kitty/kitty.conf"
    )

    for opt in "${options[@]}"; do
        read -r key label path <<< "$opt"
        printf "  [%s] %s\n" "$key" "$label"
    done

    read -rsn1 key
    [[ -z "$key" || "$key" == "q" ]] && return

    for opt in "${options[@]}"; do
        read -r k _ path <<< "$opt"
        [[ "$k" == "$key" ]] && nvim "$path" && return
    done

    echo "Invalid key: $key"
}

# TUI file explorer
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# For practice sessions
record() {
    local title="${1:+$1-}"
    local base=~/Music/Guitar/${title}$(date +%Y-%m-%d)
    local file="${base}.wav"
    local i=2
    while [[ -f "$file" ]]; do
        file="${base}-${i}.wav"
        ((i++))
    done
    pw-record --rate 48000 --format s24 --channels 1 "$file"
}

# Quickly shell into Docker containers
d() {
	local list filtered containerName shell

	list=$(docker ps --format {{.Names}})
	[[ -n "$1" ]] && filtered=$(fzf --filter="$1" --ignore-case <<< "$list")

	containerName=$(fzf --select-1 --ignore-case --prompt='  Container: ' <<< "${filtered:-$list}")
	[[ -z "$containerName" ]] && return

	[[ "$containerName" == *php* ]] && shell=bash || shell=sh
	docker exec -it "$containerName" "$shell"
}
