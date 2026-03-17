#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

shopt -s autocd
export PATH="$PATH:/home/username/.local/share/JetBrains/Toolbox/scripts"
export PATH="$PATH:/home/username/.local/bin"
export AWS_PROFILE=optic

# Symlink current script to ~/.local/bin                                                
dsh() {                                                  
	declare -A containers=(
		[modp]="optic_modx_php"                       
		[modn]="optic_modx_nginx"
		[lavp]="optic_laravel_php"
		[lavn]="optic_laravel_nginx"
	)

	local name="${containers[$1]}"
	if [ -z "$name" ]; then
		echo "Unknown alias '$1'. Available:
		${!containers[*]}"
		return 1
	fi

	docker exec -it "$name" bash 2>/dev/null || docker
	exec -it "$name" sh
}

# in order to use nvm (node version manager)
source /usr/share/nvm/init-nvm.sh

# for zoxide
eval "$(zoxide init bash)"

alias c=cd
alias e=eza
alias v=nvim

cl() {
	cd $1 && ls
}

zz() {
	z $1 && eza
}

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


# for .dotfile bare repo
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles.git/" --work-tree="$HOME"'
