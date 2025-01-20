sudo pacman -S --noconfirm fish
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf install https://github.com/icezyclon/zoxide.fish/tree/main
