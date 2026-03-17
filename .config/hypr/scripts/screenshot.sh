#!/bin/bash
# screenshot.sh [region|window|screen]
# Captures screenshot via hyprshot → annotate via satty → save + clipboard

MODE=${1:-region}
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
OUTPUT="$HOME/Pictures/Screenshots/${TIMESTAMP}_${MODE}.png"

case "$MODE" in
    region)
        hyprshot -m region --raw | satty --filename - --copy-command wl-copy --output-filename "$OUTPUT"
        ;;
    window)
        hyprshot -m window --raw | satty --filename - --copy-command wl-copy --output-filename "$OUTPUT"
        ;;
    screen)
        hyprshot -m output --raw | satty --filename - --copy-command wl-copy --output-filename "$OUTPUT"
        ;;
esac
