#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers/3440x1440"
MONITOR="DP-3"

# Pick a random wallpaper, excluding the current one if possible
current=$(awww query | grep "$MONITOR" | grep -oP 'image: \K.*')
mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.webp" \) | grep -v "^$current$")

[ ${#wallpapers[@]} -eq 0 ] && exit 0

pick="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

awww img "$pick" \
    --outputs "$MONITOR" \
    --transition-type fade \
    --transition-duration 1
