#!/bin/sh
# shellcheck disable=SC2059

#
# THIS SCRIPT SHOULD ONLY BE USED INSIDE A DEVCONTAINER
#

set -euf

readonly RESET="\033[0m"
readonly RED="\033[0;31m"
readonly GREEN="\033[0;32m"
readonly CYAN="\033[0;36m"
readonly BOLD="\033[1m"

printf "${CYAN}Setting up dotfiles for devcontainer...${RESET}\n"

if command -v sudo > /dev/null 2>&1; then
    SUDO=sudo
elif command -v doas > /dev/null 2>&1; then
    SUDO=doas
else
    printf "${RED}Error: sudo or doas required${RESET}\n"
    exit 1
fi

if command -v apt-get > /dev/null 2>&1; then
    printf "${CYAN}Using package manager: ${BOLD}apt-get${RESET}\n"
    $SUDO apt-get update
    $SUDO apt-get install -y stow fzf ripgrep starship zoxide neovim lazygit git-delta nodejs
elif command -v apk > /dev/null 2>&1; then
    printf "${CYAN}Using package manager: ${BOLD}apk${RESET}\n"
    $SUDO apk update
    $SUDO apk add stow fzf ripgrep starship zoxide neovim lazygit git-delta nodejs
elif command -v pacman > /dev/null 2>&1; then
    printf "${CYAN}Using package manager: ${BOLD}pacman${RESET}\n"
    $SUDO pacman -Sy --noconfirm stow fzf ripgrep starship zoxide neovim lazygit git-delta nodejs
else
    printf "${RED}Error: No supported package manager found${RESET}\n"
    exit 1
fi

touch "$HOME/dotfiles/nvim/lua/custom.lua"

stow -t ~/.config -R .
ln -sf "$HOME/dotfiles/.bashrc" ~/.bashrc

printf "${GREEN}✓ Dotfiles installed successfully${RESET}\n"
