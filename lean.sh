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
    $SUDO apt-get install -y stow fzf ripgrep starship zoxide curl
elif command -v apk > /dev/null 2>&1; then
    printf "${CYAN}Using package manager: ${BOLD}apk${RESET}\n"
    $SUDO apk update
    $SUDO apk add stow fzf ripgrep starship zoxide curl
elif command -v pacman > /dev/null 2>&1; then
    printf "${CYAN}Using package manager: ${BOLD}pacman${RESET}\n"
    $SUDO pacman -Sy --noconfirm stow fzf ripgrep starship zoxide curl
else
    printf "${RED}Error: No supported package manager found${RESET}\n"
    exit 1
fi

printf "${CYAN}Installing latest Neovim from GitHub releases...${RESET}\n"

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

NVIM_ARCH=$(uname -m | sed 's/aarch64/arm64/')
NVIM_TARBALL="nvim-linux-${NVIM_ARCH}.tar.gz"
printf "${CYAN}Downloading ${NVIM_TARBALL}...${RESET}\n"

curl -LO "https://github.com/neovim/neovim/releases/latest/download/${NVIM_TARBALL}"

$SUDO tar -C /opt -xzf "$NVIM_TARBALL"
$SUDO ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim

cd - > /dev/null
rm -rf "$TEMP_DIR"

touch "$HOME/dotfiles/nvim/lua/custom.lua"

stow -R .
ln -sf "$HOME/dotfiles/.bashrc" ~/.bashrc

printf "${GREEN}✓ Dotfiles installed successfully${RESET}\n"

exit 0
