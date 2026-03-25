#!/bin/bash
RECORDINGS_DIR="$HOME/Videos/screenrecordings"
PIDFILE="/tmp/gpu-screen-recorder.pid"
TMPFILE="/tmp/screenrec_tmp.mp4"

mkdir -p "$RECORDINGS_DIR"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    PID=$(cat "$PIDFILE")
    kill -SIGINT "$PID"
    while kill -0 "$PID" 2>/dev/null; do sleep 0.1; done
    rm -f "$PIDFILE"
    pkill -RTMIN+9 waybar

    NAME=$(rofi -dmenu -p "Save recording: " -theme ~/.config/hypr/scripts/recording-prompt.rasi)

    if [ $? -ne 0 ]; then
        rm -f "$TMPFILE"
        notify-send -e -i media-record -t 2000 "Screen Recording" "Recording discarded."
    else
        [ -z "$NAME" ] && NAME=$(date '+%Y-%m-%dT%H:%M_screenrecording')
        NAME="${NAME#/}"; NAME="${NAME%/}"
        [[ "$NAME" != *.mp4 ]] && NAME="${NAME}.mp4"
        DEST="$RECORDINGS_DIR/$NAME"
        mkdir -p "$(dirname "$DEST")"
        mv "$TMPFILE" "$DEST"
        notify-send -e -i media-record -t 4000 "Screen Recording Saved" "~/Videos/screenrecordings/$NAME"
    fi
else
    gpu-screen-recorder -w DP-3 -f 60 -a default_output -k h264 -q very_high -o "$TMPFILE" &
    echo $! > "$PIDFILE"
    pkill -RTMIN+9 waybar
    notify-send -e -i media-record -t 2000 "Screen Recording Started" ""
fi
