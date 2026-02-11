#!/bin/sh

set -euf

RESET=$(printf '\033[0m')
RED=$(printf '\033[0;31m')
GREEN=$(printf '\033[0;32m')
YELLOW=$(printf '\033[0;33m')
CYAN=$(printf '\033[0;36m')

append_line() {
    new_line="$1"
    filepath="$2"
    while IFS= read -r line; do
      [ "$line" = "$new_line" ] && return 0
    done < "$filepath"

    echo "$new_line" >> "$filepath"
}

if [ ! -t 0 ]; then
  printf "%s✗ Not interactive. Exiting...%s\n" "$RED" "$RESET"
  exit 1
fi

if [ "$(id -u)" = "0" ]; then
  printf "%sRunning as root. No privilege elevation needed.%s\n" "$GREEN" "$RESET"
  SUDO=""
else
  if command -v doas > /dev/null 2>&1; then
    SUDO=doas
  elif command -v sudo > /dev/null 2>&1; then
    SUDO=sudo
  else
    printf "%s✗ Sudo or doas is not installed and is required for non-root users! Please install one of them manually!%s\n" "$RED" "$RESET"
    exit 1
  fi
fi

# Check if the Linux distro is Arch based
IS_ARCH_BASED="false"

if command -v pacman > /dev/null 2>&1; then
    printf "%sArch based system detected.%s\n" "$GREEN" "$RESET"
    IS_ARCH_BASED="true"
fi

# Check if git is installed, prompt the user for install if not
if ! command -v git > /dev/null 2>&1; then
  if [ "$IS_ARCH_BASED" = "false" ]; then
    printf "%s✗ Git is not installed and is required! Please install it manually!%s\n" "$RED" "$RESET"
    exit 1
  fi

  printf "%sGit is not installed and is required, do you wish to install it? (y/N): %s" "$YELLOW" "$RESET"
  read -r answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $SUDO pacman -S git
  else
    printf "%s✗ Exiting...%s\n" "$RED" "$RESET"
    exit 1
  fi
fi

# Check if stow is installed, prompt the user for install if not
if ! command -v stow > /dev/null 2>&1; then
  if [ "$IS_ARCH_BASED" = "false" ]; then
    printf "%s✗ Stow is not installed and is required! Please install it manually!%s\n" "$RED" "$RESET"
    exit 1
  fi

  printf "%sStow is not installed and is required, do you wish to install it? (y/N): %s" "$YELLOW" "$RESET"
  read -r answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $SUDO pacman -S stow
  else
    printf "%s✗ Exiting...%s\n" "$RED" "$RESET"
    exit 1
  fi
fi

# Ask the user if they want to install needed packages
IS_DESKTOP="false"

if [ "$IS_ARCH_BASED" = "true" ]; then
  printf "%sDo you want to install the packages to make Neovim work? (y/N): %s" "$CYAN" "$RESET"
  read -r answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $SUDO pacman -S zellij atuin bat neovim fd fzf lsd ripgrep zoxide starship lazygit git-delta nodejs
  fi
  printf "%sDo you want the full desktop experience? (y/N): %s" "$CYAN" "$RESET"
  read -r answer
  if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    $SUDO pacman -S foot fuzzel grim slurp wl-clipboard libnotify swaync brightnessctl playerctl hyprland hyprpicker hypridle hyprlock hyprsunset keepassxc ttf-dejavu-nerd ttf-jetbrains-mono-nerd
    IS_DESKTOP="true"
  fi
else
  printf "%sSkipping packages install because the script is not running on an Arch based distro!%s\n" "$YELLOW" "$RESET"
fi

# Ask the user to enter a path to store the dotfiles
printf "%sEnter the full path where the dotfiles will be saved. (Default: ~/Documents/dotfiles/): %s" "$CYAN" "$RESET"
read -r CHOSEN_PATH
CHOSEN_PATH="${CHOSEN_PATH:-$HOME/Documents}"

if [ ! -d "$CHOSEN_PATH" ]; then
    printf "%sThe path '%s' is not valid or does not exist. Do you wish to create it? (y/N): %s" "$YELLOW" "$CHOSEN_PATH" "$RESET"
    read -r answer
    if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
      mkdir -p "$CHOSEN_PATH"
    else
      printf "%s✗ Exiting...%s\n" "$RED" "$RESET"
      exit 1
    fi
fi

# Clone the repository and handle existing directory
if [ -d "$CHOSEN_PATH/dotfiles/.git" ]; then
    printf "%sExisting git repository found. Updating...%s\n" "$GREEN" "$RESET"
    cd "$CHOSEN_PATH/dotfiles"
    git fetch origin
    git pull origin master
    cd -
elif [ -d "$CHOSEN_PATH/dotfiles" ] && [ "$(ls -A "$CHOSEN_PATH/dotfiles" 2>/dev/null)" ]; then
    printf "%s✗ Directory '%s/dotfiles' exists but is not a git repository! Please remove it manually or choose a different path.%s\n" "$RED" "$CHOSEN_PATH" "$RESET"
    exit 1
else
    git clone https://github.com/Sawangg/dotfiles.git "$CHOSEN_PATH/dotfiles"
fi

# Configure apps to better match the environment using custom.conf
custom_hypr="$CHOSEN_PATH/dotfiles/hypr/hyprland/custom.conf"
touch "$custom_hypr"
custom_nvim="$CHOSEN_PATH/dotfiles/nvim/lua/custom.lua"
touch "$custom_nvim"

if lsmod | grep -i nvidia > /dev/null; then
    printf "%sNVIDIA GPU detected. Adding NVIDIA configuration to Hyprland custom.conf.%s\n" "$GREEN" "$RESET"
    append_line "source = ~/.config/hypr/hyprland/nvidia.conf" "$custom_hypr"
fi

printf "%sDo you wish to use the French AZERTY keyboard layout as the default (y/N): %s" "$CYAN" "$RESET"
read -r answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    append_line "source = ~/.config/hypr/hyprland/azerty.conf" "$custom_hypr"
    append_line "require(\"azerty\")" "$custom_nvim"
fi

printf "%sInstall for which system user? (username or 'current' or comma-separated list) [current]: %s" "$CYAN" "$RESET"
read -r TARGET_USERS
TARGET_USERS="${TARGET_USERS:-current}"

if [ "$TARGET_USERS" = "current" ]; then
  TARGET_USERS=$(id -un)
fi

# Install for each user
OLD_IFS=$IFS
IFS=','
for user in $TARGET_USERS; do
  user=$(printf "%s" "$user" | xargs)
  if [ -z "$user" ]; then
    continue
  fi
  TARGET_HOME=$(getent passwd "$user" | cut -d: -f6 || printf "")
  if [ -z "$TARGET_HOME" ]; then
    printf "%s✗ User '%s' not found, skipping.%s\n" "$RED" "$user" "$RESET"
    continue
  fi

  printf "%sInstalling dotfiles for user: %s (home: %s)%s\n" "$CYAN" "$user" "$TARGET_HOME" "$RESET"

  # Ensure .config exists
  if [ ! -d "$TARGET_HOME/.config" ]; then
    if [ -n "$SUDO" ]; then
      $SUDO mkdir -p "$TARGET_HOME/.config" && $SUDO chown -R "$user":"$user" "$TARGET_HOME/.config"
    else
      mkdir -p "$TARGET_HOME/.config" && chown -R "$user":"$user" "$TARGET_HOME/.config"
    fi
  fi

  # Symlink dotfiles using stow
  # TODO: Handle existing files (backup or skip)
  if [ -n "$SUDO" ]; then
    $SUDO -u "$user" stow -d "$CHOSEN_PATH/dotfiles" -t "$TARGET_HOME/.config" -R .
  else
    su - "$user" -c stow -d "$CHOSEN_PATH/dotfiles" -t "$TARGET_HOME/.config" -R .
  fi

  # Setup bashrc, bash_profile & gitconfig symlinks
  if [ -n "$SUDO" ]; then
    $SUDO -u "$user" ln -sf "$CHOSEN_PATH/dotfiles/.bashrc" "$TARGET_HOME/.bashrc"
    $SUDO -u "$user" ln -sf "$CHOSEN_PATH/dotfiles/.gitconfig" "$TARGET_HOME/.gitconfig"
  else
    su - "$user" -c "ln -sf '$CHOSEN_PATH/dotfiles/.bashrc' '$TARGET_HOME/.bashrc'"
    su - "$user" -c "ln -sf '$CHOSEN_PATH/dotfiles/.gitconfig' '$TARGET_HOME/.gitconfig'"
  fi
  if [ "$IS_DESKTOP" = "true" ]; then
    if [ -n "$SUDO" ]; then
      $SUDO -u "$user" ln -sf "$CHOSEN_PATH/dotfiles/.bash_profile" "$TARGET_HOME/.bash_profile"
    else
      su - "$user" -c "ln -sf '$CHOSEN_PATH/dotfiles/.bash_profile' '$TARGET_HOME/.bash_profile'"
    fi
  fi

  printf "%s✓ Installed for %s%s\n" "$GREEN" "$user" "$RESET"
done
IFS=$OLD_IFS

printf "%sSetting up global git hooks...%s\n" "$CYAN" "$RESET"
git config --global core.hooksPath ~/.config/git/hooks

printf "%sAll requested installs completed. Logout/login may be required for some changes.%s\n" "$GREEN" "$RESET"
hyprctl reload
