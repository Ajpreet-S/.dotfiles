#!/bin/bash

# Usage: waybar-git-branch-switch.sh [remote]
REPO="$HOME/optic-systems/OS-laravel/optic-systems-legacy/core/repositories/jampack"
THEME="$HOME/.config/waybar/scripts/git-branch.rasi"

pkill rofi

if [[ "$1" == "remote" ]]; then
    branches=$(git -C "$REPO" branch -r --format='%(refname:short)' | sed 's|origin/||')
    prompt="Remote branch:"
    highlight="element selected normal, element selected active { background-color: rgba(180,30,30,0.8); }"
else
    branches=$(git -C "$REPO" branch --format='%(refname:short)')
    prompt="Switch branch:"
    highlight=""
fi

branch=$(echo "$branches" | \
	rofi -dmenu -i -matching fuzzy -hover-select -no-custom  \
    -theme "$THEME" -theme-str "$highlight")

[[ -n "$branch" ]] && git -C "$REPO" switch "$branch"
