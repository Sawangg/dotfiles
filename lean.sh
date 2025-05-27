#!/bin/sh

#
# THIS SCRIPT SHOULD ONLY BE USED INSIDE A DEVCONTAINER
#

readonly RESET="\033[0m"
readonly RED="\033[0;31m"
readonly GREEN="\033[0;32m"
readonly YELLOW="\033[1;33m"
readonly CYAN="\033[0;36m"
readonly BOLD="\033[1m"

check_command() {
  type "$1" > /dev/null 2>&1
}

install_packages() {
    if [ $# -eq 0 ]; then
        printf "${RED}Error: No packages specified for installation${RESET}\n" >&2
        return 1
    fi

    case "$PACKAGE_MANAGER" in
        "apt-get")
            $ELEVATED_PRIVILEGE_CMD apt-get install -y "$@"
            ;;
        "apk")
            $ELEVATED_PRIVILEGE_CMD apk add "$@"
            ;;
        "pacman")
            $ELEVATED_PRIVILEGE_CMD pacman -Sy --noconfirm "$@"
            ;;
        *)
            printf "${RED}Error: Unsupported package manager '${YELLOW}%s${RED}'${RESET}\n" "$PACKAGE_MANAGER" >&2
            return 1
            ;;
    esac
}

printf "${CYAN}Executing the leaner dotfiles script for devcontainers.${RESET}\n"

if check_command doas; then
    ELEVATED_PRIVILEGE_CMD=doas
elif check_command sudo; then
    ELEVATED_PRIVILEGE_CMD=sudo
else
    printf "${RED}sudo or doas is not installed and is required to run this script!${RESET}\n"
    exit 1
fi

if check_command apt-get; then
    PACKAGE_MANAGER="apt-get"
    printf "${CYAN}Found package manager: ${BOLD}apt-get${RESET}\n"
    $ELEVATED_PRIVILEGE_CMD apt-get update
elif check_command apk; then
    PACKAGE_MANAGER="apk"
    printf "${CYAN}Found package manager: ${BOLD}apk${RESET}\n"
    $ELEVATED_PRIVILEGE_CMD apk update
elif check_command pacman; then
    PACKAGE_MANAGER="pacman"
    printf "${CYAN}Found package manager: ${BOLD}pacman${RESET}\n"
else
    printf "${RED}No supported package manager found. Exiting...${RESET}\n"
    exit 1
fi

install_packages stow fzf ripgrep curl #atuin bat lsd zoxide starship

printf "${CYAN}Installing Neovim AppImage...${RESET}\n"
TEMP_DIR=$(mktemp -d)
ORIGINAL_DIR=$(pwd)
cd "$TEMP_DIR" || exit 1
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
$ELEVATED_PRIVILEGE_CMD mv nvim.appimage /usr/local/bin/nvim
cd "$ORIGINAL_DIR"
rm -rf "$TEMP_DIR"

stow -R .

printf "${GREEN}✓ Installed the dotfiles successfully.${RESET}\n"
