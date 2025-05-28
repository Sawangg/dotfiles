#!/bin/sh

set -euf

readonly RESET="\033[0m"
readonly RED="\033[0;31m"
readonly GREEN="\033[0;32m"
readonly YELLOW="\033[1;33m"
readonly CYAN="\033[0;36m"

append_line() {
    local new_line="$1"
    local path="$2"
    while IFS= read -r line; do
      [ "$line" = "$new_line" ] && return 0
    done < "$path"

    echo "$new_line" >> "$path"
}

if [ ! -t 0 ]; then
  printf "${RED}✗ Not interactive. Exiting...${RESET}\n"
  exit 1
fi

if [ "$(id -u)" = "0" ]; then
  printf "${GREEN}Running as root. No privilege elevation needed.${RESET}\n"
  SUDO=""
else
  if command -v doas > /dev/null 2>&1; then
    SUDO=doas
  elif command -v sudo > /dev/null 2>&1; then
    SUDO=sudo
  else
    printf "${RED}✗ Sudo or doas is not installed and is required for non-root users! Please install one of them manually!${RESET}\n"
    exit 1
  fi
fi

# Check if the Linux distro is Arch based
IS_ARCH_BASED="false"

if command -v pacman > /dev/null 2>&1; then
    printf "${GREEN}Arch based system detected.${RESET}\n"
    IS_ARCH_BASED="true"
fi

# Check if git is installed, prompt the user for install if not
if ! command -v git > /dev/null 2>&1; then
  if [ "$IS_ARCH_BASED" = "false" ]; then
    printf "${RED}✗ Git is not installed and is required! Please install it manually!${RESET}\n"
    exit 1
  fi

  printf "${YELLOW}Git is not installed and is required, do you wish to install it? (y/N): ${RESET}"
  read answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $SUDO pacman -S git
  else
    printf "${RED}✗ Exiting...${RESET}\n"
    exit 1
  fi
fi

# Check if stow is installed, prompt the user for install if not
if ! command -v stow > /dev/null 2>&1; then
  if [ "$IS_ARCH_BASED" = "false" ]; then
    printf "${RED}✗ Stow is not installed and is required! Please install it manually!${RESET}\n"
    exit 1
  fi

  printf "${YELLOW}Stow is not installed and is required, do you wish to install it? (y/N): ${RESET}"
  read answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $SUDO pacman -S stow
  else
    printf "${RED}✗ Exiting...${RESET}\n"
    exit 1
  fi
fi

# Ask the user if they want to install needed packages
if [ "$IS_ARCH_BASED" = "true" ]; then
  printf "${CYAN}Do you wish to install all the packages needed to make the dotfiles work? (y/N): ${RESET}"
  read answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $SUDO pacman -S foot zellij atuin bat neovim fd fzf lsd ripgrep zoxide starship grim slurp wl-clipboard libnotify brightnessctl playerctl hyprland hyprpicker hypridle hyprlock hyprsunset keepassxc
  fi
else
  printf "${YELLOW}Skipping packages install because the script is not running on an Arch based distro!${RESET}\n"
fi

# TODO: Prompt the user to choose for which system user the dotfiles will be installed for

# Ask the user to enter a path to store the dotfiles
printf "${CYAN}Enter the full path where the dotfiles will be saved. (Default: ~/Documents/dotfiles/): ${RESET}"
read CHOSEN_PATH
CHOSEN_PATH="${CHOSEN_PATH:-$HOME/Documents}"

if [ ! -d "$CHOSEN_PATH" ]; then
    printf "${YELLOW}The path '$CHOSEN_PATH' is not valid or does not exist. Do you wish to create it? (y/N): ${RESET}"
    read answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
      mkdir -p "$CHOSEN_PATH"
    else
      printf "${RED}✗ Exiting...${RESET}\n"
      exit 1
    fi
fi

# Clone the repository and handle existing directory
if [ -d "$CHOSEN_PATH/dotfiles/.git" ]; then
    printf "${GREEN}Existing git repository found. Updating...${RESET}\n"
    cd "$CHOSEN_PATH/dotfiles"
    git fetch origin
    git pull origin master
    cd -
elif [ -d "$CHOSEN_PATH/dotfiles" ] && [ "$(ls -A "$CHOSEN_PATH/dotfiles" 2>/dev/null)" ]; then
    printf "${RED}✗ Directory '$CHOSEN_PATH/dotfiles' exists but is not a git repository! Please remove it manually or choose a different path.${RESET}\n"
    exit 1
else
    git clone https://github.com/Sawangg/dotfiles.git "$CHOSEN_PATH"
fi

# Configure apps to better match the environment using custom.conf
custom_hypr="$CHOSEN_PATH/dotfiles/hypr/hyprland/custom.conf"
touch "$custom_hypr"
custom_nvim="$CHOSEN_PATH/dotfiles/nvim/lua/custom.lua"
touch "$custom_nvim"

if lsmod | grep -i nvidia > /dev/null; then
    printf "${GREEN}NVIDIA GPU detected. Adding NVIDIA configuration to Hyprland custom.conf.${RESET}\n"
    append_line "source = ~/.config/hypr/hyprland/nvidia.conf" "$custom_hypr"
fi

printf "${CYAN}Do you wish to use the French AZERTY keyboard layout as the default (y/N): ${RESET}"
read answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    append_line "source = ~/.config/hypr/hyprland/azerty.conf" "$custom_hypr"
    append_line "require(\"azerty\")" "$custom_nvim"
fi

# Symlink to destination
printf "${GREEN}Creating symlinks...${RESET}\n"
cd "$CHOSEN_PATH/dotfiles"

# TODO: Handle conflicting files using adopt or override
stow -R .
ln -sf "$CHOSEN_PATH/dotfiles/.bash_profile" ~/.bash_profile
ln -sf "$CHOSEN_PATH/dotfiles/.bashrc" ~/.bashrc

. ~/.bashrc

printf "${GREEN}✓ Dotfiles setup completed successfully! Logout and log back in to see the changes!${RESET}\n"
