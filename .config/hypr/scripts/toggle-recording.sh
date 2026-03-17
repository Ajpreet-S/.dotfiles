#!/bin/bash
# Toggle GPU screen recording. Saves to ~/Videos/Recordings/ with timestamps.

RECORDINGS_DIR="$HOME/Videos/ScreenRecordings"
PIDFILE="/tmp/gpu-screen-recorder.pid"

mkdir -p "$RECORDINGS_DIR"

if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    # STOP recording
    PID=$(cat "$PIDFILE")
    kill -SIGINT "$PID"
    wait "$PID" 2>/dev/null
    rm -f "$PIDFILE"
    notify-send -e -i media-record -t 2000 "Screen Recording" "Recording stopped and saved to ~/Videos/Recordings/"
else
    # START recording
    TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
    OUTPUT_FILE="$RECORDINGS_DIR/${TIMESTAMP}_screenrecording.mp4"

    gpu-screen-recorder \
        -w DP-3 \
        -f 60 \
        -a default_output \
        -k h264 \
        -q very_high \
        -o "$OUTPUT_FILE" &

    echo $! > "$PIDFILE"
    notify-send -e -i media-record -t 2000 "Screen Recording" "Recording started — DP-3 @ 60fps\nSaving: ${TIMESTAMP}_recording.mp4"
fi
