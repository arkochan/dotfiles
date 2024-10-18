#!/bin/bash

firefox_desktop_file="$HOME/.config/bspwm/src/firefox_desktop_3"
figma_link="https://www.figma.com/design/3UbEmCzMoQvbTd87S0e4fk/Food-App---FoodHub-(Community)-(Community)?node-id=814-7045&node-type=FRAME&t=nlrulOKYcvT0zBHk-0"
PROJECT_DIR="$HOME/Repositories/krunch-cloud-next/"

cd "$PROJECT_DIR" || exit

# Directory to create a temoprary file

# A file is created which is later chekked if firefox is to be opened in desktop 3
touch "$firefox_desktop_file" &
# Switch to desktop 3 and Start NeoVim with a script case alacrity cant execute a script with argument
bspc desktop -f 3 && alacritty --class "nvim" -e "nvim_at_directory.sh" &

nvim_found=false
sleep_duration=0
while [ "$nvim_found" == false ]; do
  for id in $(bspc query -N -d '^3' -n .window); do
    if xprop -id "$id" | grep -q "nvim"; then
      # Shrink the Firefox window in workspace 3
      nvim_found=true # Set firefox_found to true when Firefox is found
      echo "Starting up nvim took $sleep_duration seconds"
      break # Exit the for loop after finding and resizing Firefox
    fi
  done
  sleep 0.1
  sleep_duration=$(echo "$sleep_duration + 0.1" | bc)
done

firefox "$figma_link" "http://localhost:3000" &
# Launch Firefox
echo "hola"

# Wait for firefox to open and be registered

#Require to select the firefox window opened in workspace 3
firefox_found=false # Initialize the variable

sleep_nvim=$sleep_duration
sleep_duration=0

while [ "$firefox_found" == false ]; do
  for id in $(bspc query -N -d '^3' -n .window); do
    if xprop -id "$id" | grep -q "WM_CLASS.*firefox"; then
      # Shrink the Firefox window in workspace 3
      bspc node "$id" -s east
      bspc node "$id" -z left 340 0
      firefox_found=true # Set firefox_found to true when Firefox is found
      echo "Starting up firefox took $sleep_duration seconds"
      dunstify "Project Started" "Nvim took $sleep_nvim seconds\nfirefox took $sleep_duration seconds" -t 3000
      break # Exit the for loop after finding and resizing Firefox

    fi
  done
  sleep 0.1
  sleep_duration=$(echo "$sleep_duration + 0.1" | bc)
done
# Remove the identifier file
rm "$firefox_desktop_file" &

pnpm dev
