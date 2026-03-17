#!/bin/bash
# Toggle the HUD terminal scratchpad.
# Spawns a new kitty instance on special:term if none exists, then toggles visibility.

TERM_COUNT=$(hyprctl clients -j | jq '[.[] | select(.workspace.name == "special:term")] | length')

if [ "$TERM_COUNT" -eq 0 ]; then
    hyprctl dispatch exec "[workspace special:term silent] kitty --class term-hud"
    sleep 0.2
fi

hyprctl dispatch togglespecialworkspace term
