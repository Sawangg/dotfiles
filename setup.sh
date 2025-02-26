#!/bin/sh

check_command() {
  command -v "$1" &> /dev/null
}

# Set the default tool for elevated privileges
ELEVATED_PRIVILEGE_CMD=doas
if check_command doas; then
  ELEVATED_PRIVILEGE_CMD=doas
elif check_command sudo; then
  ELEVATED_PRIVILEGE_CMD=sudo
else
  echo "Sudo or doas is not installed and is required! Please install one of them manually!"
  exit 1
fi

# Check if the Linux distro is Arch based
IS_ARCH_BASED="false"

if check_command pacman && check_command yay; then
    echo "Arch based system detected."
    IS_ARCH_BASED="true"
fi

# Check if git is installed, prompt the user for install if not
if ! check_command git; then
  if [[ "$IS_ARCH_BASED" == "false" ]]; then
    echo "Git is not installed and is required! Please install it manually!"
    exit 1
  fi

  read -p "Git is not installed and is required, do you wish to install it? (y/N): " answer
  if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    $ELEVATED_PRIVILEGE_CMD pacman -S git
  else
    echo "Exiting..."
    exit 1
  fi
fi

# Check if git is installed, prompt the user for install if not
if ! check_command stow; then
  if [[ "$IS_ARCH_BASED" == "false" ]]; then
    echo "Stow is not installed and is required! Please install it manually!"
    exit 1
  fi

  read -p "Stow is not installed and is required, do you wish to install it? (y/N): " answer
  if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    $ELEVATED_PRIVILEGE_CMD pacman -S stow
  else
    echo "Exiting..."
    exit 1
  fi
fi

# Ask the user if he/she wants to install the needed packages.
if [[ "$IS_ARCH_BASED" == "true" ]]; then
  read -p "Do you wish to install all the packages needed to make the dotfiles work? (y/N): " answer
  if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    $ELEVATED_PRIVILEGE_CMD pacman -S foot zellij atuin bat neovim fd fzf lsd ripgrep zoxide starship grim slurp wl-clipboard libnotify brightnessctl playerctl hyprland hyprpicker hypridle hyprlock hyprsunset keepassxc
    yay -S tofi
  fi
else
  echo "Skipping packages install because the script is not running on an Arch based distro!"
fi

# TODO: Prompt the user to choose for which system user the dotfiles will be installed for

# Ask the user to enter a path to store the dotfiles
read -p "Enter the full path where the dotfiles will be saved. (Default: ~/Documents/): " CHOSEN_PATH
CHOSEN_PATH="${CHOSEN_PATH:-$HOME/Documents}"

if [ ! -d "$CHOSEN_PATH" ]; then
    read -p "The path '$CHOSEN_PATH' is not valid or does not exist. Do you wish to create it? (y/N): " answer
    if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
      mkdir -p "$CHOSEN_PATH"
    else
      echo "Exiting..."
      exit 1
    fi
fi

git clone https://github.com/Sawangg/dotfiles.git $CHOSEN_PATH

echo "Creating symlinks..."
cd $CHOSEN_PATH/dotfiles
stow -R .
ln -sf $CHOSEN_PATH/dotfiles/.bash_profile ~/.bash_profile
ln -sf $CHOSEN_PATH/dotfiles/.bashrc ~/.bashrc

# bat cache --build

# source ~/.bashrc

echo "Dotfiles setup completed successfully! You can logout and log back in to see the changes!"
