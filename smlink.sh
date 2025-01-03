#!/bin/bash

# Define the target directory
target_dir="$HOME/.config"

# Iterate over all files and directories in the current directory
for item in *; do
  # Skip the script file itself
  if [[ "$item" == "${BASH_SOURCE[0]##*/}" ]]; then
    continue
  fi

  echo "Execute this command?" "ln -sv" "$(pwd)/$item" "$target_dir/"
  read -r -p "Are you sure? [Y/n] " response
  if $response; then
     ln -sv "$(pwd)/$item" "$target_dir/"

done

echo "Done!"
