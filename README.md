This is my dotfiles repository containing all my configs.

# Install

Install every dotfiles and my bash config by using GNU/Stow and symlinks
```sh
git clone https://github.com/Sawangg/dotfiles.git ~/Documents/dotfiles/
cd ~/Documents/dotfiles/
stow -R --target ~/.config --ignore=.bashrc .
ln -sf ~/Documents/dotfiles/.bashrc ~/.bashrc
source ~/.bashrc
```

# TODO

Try NixOS and upload `configurations.nix` for a fully portable & replicable system.
