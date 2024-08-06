This is my dotfiles repository containing all of my configs.

# Install

Install every dotfiles and my bash config by using GNU/Stow and symlinks
```sh
git clone https://github.com/Sawangg/dotfiles.git ~/Documents/dotfiles/
cd ~/Documents/dotfiles/
stow -R .
ln -sf ~/Documents/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
```
