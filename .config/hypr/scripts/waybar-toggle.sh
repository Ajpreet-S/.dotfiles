#!/bin/bash
# Usage: waybar-toggle.sh <module-name> <signal-number>
# Example: waybar-toggle.sh git-branch 8

STATE_FILE="$HOME/.cache/waybar-${1}-visible"
state=$(cat "$STATE_FILE" 2>/dev/null || echo "1")
echo $(( 1 - state )) > "$STATE_FILE"
kill -SIGRTMIN+"${2}" "$(pidof waybar)"
