# Sawang's dotfiles

This is my dotfiles repository containing all of my configs.

![screenshot](https://github.com/user-attachments/assets/0009d61a-ef4e-45ee-ad36-683c1169cbf3)

## Install

Install every dotfiles and my bash config by using GNU/Stow and symlinks
```sh
git clone https://github.com/Sawangg/dotfiles.git ~/Documents/dotfiles/
cd ~/Documents/dotfiles/
stow -R .
ln -sf ~/Documents/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
```
