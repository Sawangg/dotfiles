#!/bin/sh

RESET="\033[0m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"

if [ ! -t 0 ]; then
  printf "${RED}Not interactive. Exiting...${RESET}\n"
  exit 1
fi

check_command() {
  type "$1" > /dev/null 2>&1
}

# Set the default tool for elevated privileges
if check_command doas; then
  ELEVATED_PRIVILEGE_CMD=doas
elif check_command sudo; then
  ELEVATED_PRIVILEGE_CMD=sudo
else
  printf "${RED}Sudo or doas is not installed and is required! Please install one of them manually!${RESET}\n"
  exit 1
fi

# Check if the Linux distro is Arch based
IS_ARCH_BASED="false"

if check_command pacman && check_command yay; then
    printf "${GREEN}Arch based system detected.${RESET}\n"
    IS_ARCH_BASED="true"
fi

# Check if git is installed, prompt the user for install if not
if ! check_command git; then
  if [ "$IS_ARCH_BASED" = "false" ]; then
    printf "${RED}Git is not installed and is required! Please install it manually!${RESET}\n"
    exit 1
  fi

  printf "${YELLOW}Git is not installed and is required, do you wish to install it? (y/N): ${RESET}"
  read answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $ELEVATED_PRIVILEGE_CMD pacman -S git
  else
    printf "${RED}Exiting...${RESET}\n"
    exit 1
  fi
fi

# Check if stow is installed, prompt the user for install if not
if ! check_command stow; then
  if [ "$IS_ARCH_BASED" = "false" ]; then
    printf "${RED}Stow is not installed and is required! Please install it manually!${RESET}\n"
    exit 1
  fi

  printf "${YELLOW}Stow is not installed and is required, do you wish to install it? (y/N): ${RESET}"
  read answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $ELEVATED_PRIVILEGE_CMD pacman -S stow
  else
    printf "${RED}Exiting...${RESET}\n"
    exit 1
  fi
fi

# Ask the user if they want to install needed packages
if [ "$IS_ARCH_BASED" = "true" ]; then
  printf "${CYAN}Do you wish to install all the packages needed to make the dotfiles work? (y/N): ${RESET}"
  read answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $ELEVATED_PRIVILEGE_CMD pacman -S foot zellij atuin bat neovim fd fzf lsd ripgrep zoxide starship grim slurp wl-clipboard libnotify brightnessctl playerctl hyprland hyprpicker hypridle hyprlock hyprsunset keepassxc
    yay -S tofi
  fi
else
  printf "${YELLOW}Skipping packages install because the script is not running on an Arch based distro!${RESET}\n"
fi

# TODO: Prompt the user to choose for which system user the dotfiles will be installed for

# Ask the user to enter a path to store the dotfiles
printf "${CYAN}Enter the full path where the dotfiles will be saved. (Default: ~/Documents/): ${RESET}"
read CHOSEN_PATH
CHOSEN_PATH="${CHOSEN_PATH:-$HOME/Documents}"

if [ ! -d "$CHOSEN_PATH" ]; then
    printf "${YELLOW}The path '$CHOSEN_PATH' is not valid or does not exist. Do you wish to create it? (y/N): ${RESET}"
    read answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
      mkdir -p "$CHOSEN_PATH"
    else
      printf "${RED}Exiting...${RESET}\n"
      exit 1
    fi
fi

git clone https://github.com/Sawangg/dotfiles.git "$CHOSEN_PATH"

# Configure Hyprland to better match the environment using custom.conf
custom_conf="$CHOSEN_PATH/dotfiles/hypr/hyprland/custom.conf"
touch "$custom_conf"

append_to_custom_conf() {
    local config="$1"
    while IFS= read -r line; do
      [ "$line" = "$config" ] && return 0 # Line already exists, no need to add to the config
    done < "$custom_conf"

    echo "$config" >> "$custom_conf"
}

if lsmod | grep -i nvidia > /dev/null; then
    printf "${GREEN}NVIDIA GPU detected. Adding NVIDIA configuration to Hyprland custom.conf.${RESET}\n"
    append_to_custom_conf "source = ~/.config/hypr/hyprland/nvidia.conf"
fi

printf "${CYAN}Do you wish to use the French AZERTY keyboard layout as the default (y/N): ${RESET}"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    append_to_custom_conf "source = ~/.config/hypr/hyprland/azerty.conf"
fi

# Symlink to destination
printf "${GREEN}Creating symlinks...${RESET}\n"
cd "$CHOSEN_PATH/dotfiles"
stow -R .
ln -sf "$CHOSEN_PATH/dotfiles/.bash_profile" ~/.bash_profile
ln -sf "$CHOSEN_PATH/dotfiles/.bashrc" ~/.bashrc

# bat cache --build

# Reload configs
source ~/.bashrc
hyprctl reload

printf "${GREEN}Dotfiles setup completed successfully! You can logout and log back in to see the changes!${RESET}\n"
