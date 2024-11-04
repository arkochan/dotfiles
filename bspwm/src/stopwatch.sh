#!/bin/bash

# File to store the elapsed time and state
TIME_FILE="$HOME/.config/bspwm/src/stopwatch_time"
STATE_FILE="$HOME/.config/bspwm/src/stopwatch_state"

# Initialize files if they don't exist
[ ! -f "$TIME_FILE" ] && echo 0 >"$TIME_FILE"
[ ! -f "$STATE_FILE" ] && echo "paused" >"$STATE_FILE"

# Load elapsed time and state
ELAPSED_TIME=$(cat "$TIME_FILE")
STATE=$(cat "$STATE_FILE")
NOW=$(date +%s)

# Functions for color and emoji
get_status_icon() {
  if [ "$STATE" = "running" ]; then
    echo "%{F#32CD32}⏳%{F-}" # Green color for running
  else
    echo "%{F#FF4500}⏸%{F-}" # Orange color for paused
  fi
}

case $1 in
play-pause)
  if [ "$STATE" = "paused" ]; then
    # Start the timer
    echo "running" >"$STATE_FILE"
    echo $((NOW - ELAPSED_TIME)) >"$TIME_FILE"
  else
    # Pause the timer
    ELAPSED_TIME=$((NOW - ELAPSED_TIME))
    echo "paused" >"$STATE_FILE"
    echo "$ELAPSED_TIME" >"$TIME_FILE"
  fi
  ;;
reset)
  # Reset the timer
  echo 0 >"$TIME_FILE"
  echo "paused" >"$STATE_FILE"
  ;;
display)
  if [ "$STATE" = "running" ]; then
    ELAPSED_TIME=$((NOW - ELAPSED_TIME))
  fi

  # Calculate hours, minutes, and seconds
  HOURS=$((ELAPSED_TIME / 3600))
  MINUTES=$(((ELAPSED_TIME % 3600) / 60))
  SECONDS=$((ELAPSED_TIME % 60))

  # Display formatted time with emoji and color
  ICON=$(get_status_icon)
  printf "%s %02d:%02d:%02d\n" "$ICON" "$HOURS" "$MINUTES" "$SECONDS"
  ;;
esac
