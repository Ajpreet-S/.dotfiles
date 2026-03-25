#!/bin/bash
# screenshot.sh [annotate]
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
OUTPUT="$HOME/Pictures/Screenshots/${TIMESTAMP}_region.png"

if [ "$1" = "annotate" ]; then
    hyprshot -m region --raw | satty --filename - --copy-command wl-copy --output-filename "$OUTPUT"
else
    hyprshot -m region --raw | tee "$OUTPUT" | wl-copy --type image/png
fi
