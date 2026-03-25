#!/bin/bash
# waybar-git-branch.sh [switch [remote] | open]
#
# No args:       display mode — outputs current branch for waybar exec
# switch:        open rofi local branch picker for the active repo
# switch remote: open rofi remote branch picker for the active repo
# open:          open kitty terminal in the active repo directory
#
# Repo list is defined in git-repos.conf (single source of truth).
# Scroll up/down on the waybar module to cycle through repos.
#
# State files (in ~/.cache/):
#   waybar-git-branch-hidden — lock file: present = hidden, absent = shown
#   waybar-git-branch-index  — active repo index (managed by waybar-module.sh)

SCRIPT_DIR="$(dirname "$0")"
THEME="$SCRIPT_DIR/git-branch.rasi"
source "$SCRIPT_DIR/git-repos.conf"

# Resolve active repo — modulo wraps index to handle negatives and overflow
count=${#REPOS[@]}
index=$(cat "$HOME/.cache/waybar-git-branch-index" 2>/dev/null || echo 0)
index=$(( (index % count + count) % count ))
entry="${REPOS[$index]}"
label="${entry%%|*}"
REPO="${entry##*|}"

case "$1" in
    switch)
        pkill rofi
        if [[ "$2" == "remote" ]]; then
            # Strip "origin/" prefix so branch names are clean
            branches=$(git -C "$REPO" branch -r --format='%(refname:short)' | sed 's|origin/||')
            # Red highlight to signal remote — destructive if force-pushed
            highlight="element selected normal, element selected active { background-color: rgba(180,30,30,0.8); }"
        else
            branches=$(git -C "$REPO" branch --format='%(refname:short)')
            highlight=""
        fi
        branch=$(echo "$branches" | rofi -dmenu -theme "$THEME" -theme-str "$highlight")
        [[ -n "$branch" ]] && git -C "$REPO" switch "$branch"
        ;;

    open)
        kitty --working-directory "$REPO"
        ;;

    *)
        # Lock file present = hidden; exit silently so waybar removes the module
        [[ -f "$HOME/.cache/waybar-git-branch-hidden" ]] && exit 0

        branch=$(git -C "$REPO" branch --show-current 2>/dev/null)
        [[ -n "$branch" ]] && echo "[$label: $branch]"
        ;;
esac
