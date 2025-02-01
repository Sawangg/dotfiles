# Sawang's dotfiles

This is my dotfiles repository containing all of my configs. I tried to achieve a consistent workflow for development as well as trying to be the perfect blend between useful, secure and pretty. Here is a list of features:

- Based on `Arch Linux` providing recent packages release
- Terminal focused, everything you need is inside the terminal
- Keyboard centric, code fast using the power of good mappings
- Full support for different keyboard layouts (`qwerty` & `azerty`)
- Consistent theme across all apps with soothing colors to limit eye strain
- Compatible with `systemd` free distros like `Artix Linux`

![screenshot](https://github.com/user-attachments/assets/0009d61a-ef4e-45ee-ad36-683c1169cbf3)

## Install

Install every dotfiles and my bash config by using GNU/Stow and symlinks

```sh
git clone https://github.com/Sawangg/dotfiles.git ~/Documents/dotfiles/
cd ~/Documents/dotfiles/
stow -R .
ln -sf ~/Documents/dotfiles/.bash_profile ~/.bash_profile
ln -sf ~/Documents/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
```
### Install Arch Packages

This is the list of all the packages the dotfiles need. A nice install script will be created in the future

```sh
doas pacman -S stow foot zellij atuin bat neovim fd fzf lsd ripgrep zoxide starship grim slurp wl-clipboard libnotify brightnessctl playerctl hyprland hyprpicker hypridle hyprlock
yay -S tofi hyprsunset
bat cache --build
```
