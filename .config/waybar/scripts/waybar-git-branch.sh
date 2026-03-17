#!/bin/bash

STATE_FILE="$HOME/.cache/waybar-git-branch-visible"
REPOS=(
    "jampack|$HOME/optic-systems/OS-laravel/optic-systems-legacy/core/repositories/jampack"
    # Add more as: "label|/path/to/repo"
)

state=$(cat "$STATE_FILE" 2>/dev/null || echo "1")
[[ "$state" != "1" ]] && exit 0

output=""
for entry in "${REPOS[@]}"; do
    label="${entry%%|*}"
    path="${entry##*|}"
    branch=$(git -C "$path" branch --show-current 2>/dev/null)
    [[ -n "$branch" ]] && output+="[$label: $branch]  "
done

echo "${output%" "}"
