#!/bin/bash

# Variables to modify
EMAIL="najmussakibarko@gmail.com" # GitHub email
KEY_NAME="ed25519"                # SSH key file name
GITHUB_USER="arkochan"            # GitHub username
SSH_DIR="$HOME/.ssh"              # Directory for SSH keys

# Step 1: Create the SSH key
echo "Generating SSH key for GitHub..."
ssh-keygen -t ed25519 -C "$EMAIL" || {
  echo "Failed to generate SSH key"
  exit 1
}

# Step 2: Start the ssh-agent and add the key
echo "Starting ssh-agent..."
eval "$(ssh-agent -s)"
ssh-add "$SSH_DIR/$KEY_NAME" || {
  echo "Failed to add SSH key to agent"
  exit 1
}

# Step 3: Display public key and copy to clipboard (requires xclip)
echo "Copying SSH key to clipboard (requires xclip)..."
cat "$SSH_DIR/$KEY_NAME.pub" | xclip -selection clipboard || { echo "Install xclip to copy key to clipboard automatically"; }

# Step 4: Print GitHub instructions
echo "Add the following SSH key to your GitHub account:"
cat "$SSH_DIR/$KEY_NAME.pub"
echo "Visit https://github.com/settings/keys, click 'New SSH key', paste the key, and save."

# Step 5: Test SSH connection to GitHub
echo "Testing SSH connection to GitHub..."
ssh -T "git@github.com" || {
  echo "Connection test failed. Ensure you've added the SSH key on GitHub"
  exit 1
}

# Step 6: Set global Git configuration
echo "Configuring global Git settings..."
git config --global user.name "$GITHUB_USER"
git config --global user.email "$EMAIL"
echo "GitHub SSH setup completed."
