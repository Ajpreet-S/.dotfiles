#!/bin/bash
# waybar-module.sh <module> <signal> <toggle|up|down>
#
# Generic controller for custom waybar modules.
# Mutates a state file then signals waybar to immediately re-exec the module script.
#
# Actions:
#   toggle — create/remove ~/.cache/waybar-<module>-hidden (lock file pattern)
#            present = hidden, absent = shown
#   up     — increment ~/.cache/waybar-<module>-index (scroll forward through items)
#   down   — decrement ~/.cache/waybar-<module>-index (scroll back through items)
#
# Index wrapping and visibility checks are handled by each module script.
# Adding a new toggleable/scrollable module only requires a keybind + scroll handler
# in config.jsonc pointing here — no changes to this script needed.

MODULE="$1"
SIGNAL="$2"
ACTION="$3"

case "$ACTION" in
    toggle)
        FILE="$HOME/.cache/waybar-${MODULE}-hidden"
        # Lock file pattern: presence = hidden, absence = shown
        [[ -f "$FILE" ]] && rm "$FILE" || touch "$FILE"
        ;;
    up|down)
        FILE="$HOME/.cache/waybar-${MODULE}-index"
        index=$(cat "$FILE" 2>/dev/null || echo 0)
        delta=1; [[ "$ACTION" == "down" ]] && delta=-1
        echo $(( index + delta )) > "$FILE"
        ;;
esac

# Signal waybar to re-exec this module's script immediately
kill -SIGRTMIN+"$SIGNAL" "$(pidof waybar)"
