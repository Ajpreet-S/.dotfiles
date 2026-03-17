#!/bin/bash
# capture-menu.sh
# Shows a small wofi menu at the top-center of the screen for selecting
# screenshot or recording mode — similar to Windows 11's Snipping Tool toolbar.

CHOICE=$(printf " Region\n Screen\n Window\n⏺ Record" \
    | wofi --dmenu \
           --location 2 \
           --width 200 \
           --height 175 \
           --prompt "" \
           --hide-scroll \
           --no-actions)

case "$CHOICE" in
    *"Region"*)  ~/.config/hypr/scripts/screenshot.sh region  ;;
    *"Screen"*)  ~/.config/hypr/scripts/screenshot.sh screen  ;;
    *"Window"*)  ~/.config/hypr/scripts/screenshot.sh window  ;;
    *"Record"*)  ~/.config/hypr/scripts/toggle-recording.sh   ;;
esac
