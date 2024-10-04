#!/bin/bash

# Run the usbtether command with sudo and capture the output
output=$(sudo adb shell svc usb setFunctions rndis)

# Check if the output contains "setCurrentFunctions opId:1"
if [[ "$output" == *"setCurrentFunctions opId:1"* ]]; then
  # If it succeeds, display Success with a tick
  notify-send "USB Tethering" "Success ✅"
  echo "Success ✅"
else
  # If it fails, display Failed
  notify-send "USB Tethering" "Failed ❌"
  echo "Failed ❌"
fi
