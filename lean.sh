#!/bin/sh

#
# THIS SCRIPT SHOULD ONLY BE USED INSIDE A DEVCONTAINER
#

set -eu

readonly RESET="\033[0m"
readonly RED="\033[0;31m"
readonly GREEN="\033[0;32m"
readonly CYAN="\033[0;36m"
readonly BOLD="\033[1m"

check_command() {
  type "$1" > /dev/null 2>&1
}

printf "${CYAN}Setting up dotfiles for devcontainer...${RESET}\n"

if check_command sudo; then
    SUDO=sudo
elif check_command doas; then
    SUDO=doas
else
    printf "${RED}Error: sudo or doas required${RESET}\n"
    exit 1
fi

if check_command apt-get; then
    printf "${CYAN}Using package manager: ${BOLD}apt-get${RESET}\n"
    $SUDO apt-get update
    $SUDO apt-get install -y stow fzf neovim ripgrep starship zoxide
elif check_command apk; then
    printf "${CYAN}Using package manager: ${BOLD}apk${RESET}\n"
    $SUDO apk update
    $SUDO apk add stow fzf neovim ripgrep starship zoxide
elif check_command pacman; then
    printf "${CYAN}Using package manager: ${BOLD}pacman${RESET}\n"
    $SUDO pacman -Sy --noconfirm stow fzf neovim ripgrep starship zoxide
else
    printf "${RED}Error: No supported package manager found${RESET}\n"
    exit 1
fi

stow -R .
ln -sf "$HOME/dotfiles/.bashrc" ~/.bashrc

printf "${GREEN}✓ Dotfiles installed successfully${RESET}\n"
