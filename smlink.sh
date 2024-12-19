#!/bin/bash

# Define the target directory
target_dir="$HOME/.config"

# Iterate over all files and directories in the current directory
for item in *; do
    # Skip the script file itself
    if [[ "$item" == "${BASH_SOURCE[0]##*/}" ]]; then
        continue
    fi

    # Create a symlink in the target directory
    ln -sv "$(pwd)/$item" "$target_dir/"
done

echo "All files have been symlinked to $target_dir."

