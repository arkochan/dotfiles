#!/bin/bash

# Define the target directory
target_dir="$HOME/.config"
green="\033[0;32m"
blue="\033[0;34m"
yellow="\033[0;33m"
red="\033[0;31m"
reset="\033[0m"

# Ensure target directory exists
mkdir -p "$target_dir"

# Iterate over all files and directories in the current directory
for item in *; do
	# Skip the script file itself
	if [[ "$item" == "${BASH_SOURCE[0]##*/}" ]]; then
		continue
	fi

	# Check if the file already exists in the target directory and ask for removal
	if [[ -e "$target_dir/$item" ]]; then
		echo -e "${yellow}Warning:${reset} File or directory '$item' already exists in $target_dir."
		read -r -p "Do you want to remove it before proceeding? [Y/n] " response
		if [[ "$response" =~ ^[Yy]$ || -z "$response" ]]; then
			echo -e "${blue}Removing${reset} existing '$item' in $target_dir..."
			rm -rf "$target_dir/$item"
		else
			echo -e "${red}Skipping${reset} '$item'. No symlink will be created."
			continue
		fi
	fi

	# Ask for user confirmation before creating the symlink
	echo -e "${green}Ready to create symlink for:${reset} $(pwd)/$item -> $target_dir/$item"
	read -r -p "Are you sure you want to create this symlink? [Y/n] " response
	if [[ "$response" =~ ^[Yy]$ || -z "$response" ]]; then
		echo -e "${blue}Creating symlink${reset} for '$item'..."
		ln -sv "$(pwd)/$item" "$target_dir/"
	else
		echo -e "${red}Skipping${reset} symlink creation for '$item'."
	fi

done

echo -e "${green}Process complete!${reset} All symlinks have been created successfully."
