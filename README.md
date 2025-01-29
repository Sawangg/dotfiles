# Sawang's dotfiles

This is my dotfiles repository containing all of my configs.

![screenshot](https://github.com/user-attachments/assets/0009d61a-ef4e-45ee-ad36-683c1169cbf3)

## Install

Install every dotfiles and my bash config by using GNU/Stow and symlinks

```sh
git clone https://github.com/Sawangg/dotfiles.git ~/Documents/dotfiles/
cd ~/Documents/dotfiles/
stow -R .
ln -sf ~/Documents/dotfiles/.bashrc ~/.bash_profile
ln -sf ~/Documents/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
```
### Install Arch Packages

This is the list of all the packages the dotfiles need. A nice install script will be created in the future

```sh
doas pacman -S hyprland foot stow zellij atuin bat lsd neovim starship grim slurp wl-clipboard zoxide fzf libnotify brightnessctl playerctl hyprpicker hypridle hyprlock
yay -S tofi hyprsunset
bat cache --build
```
