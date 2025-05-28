#!/bin/sh

#
# THIS SCRIPT SHOULD ONLY BE USED INSIDE A DEVCONTAINER
#

set -euf

readonly RESET="\033[0m"
readonly RED="\033[0;31m"
readonly GREEN="\033[0;32m"
readonly CYAN="\033[0;36m"
readonly BOLD="\033[1m"

printf "%sSetting up dotfiles for devcontainer...%s\n" "$CYAN" "$RESET"

if command -v sudo > /dev/null 2>&1; then
    SUDO=sudo
elif command -v doas > /dev/null 2>&1; then
    SUDO=doas
else
    printf "%sError: sudo or doas required%s\n" "$RED" "$RESET"
    exit 1
fi

if command -v apt-get > /dev/null 2>&1; then
    printf "%sUsing package manager: %sapt-get%s\n" "$CYAN" "$BOLD" "$RESET"
    $SUDO apt-get update
    $SUDO apt-get install -y stow fzf ripgrep starship zoxide curl
elif command -v apk > /dev/null 2>&1; then
    printf "%sUsing package manager: %sapk%s\n" "$CYAN" "$BOLD" "$RESET"
    $SUDO apk update
    $SUDO apk add stow fzf ripgrep starship zoxide curl
elif command -v pacman > /dev/null 2>&1; then
    printf "%sUsing package manager: %spacman%s\n" "$CYAN" "$BOLD" "$RESET"
    $SUDO pacman -Sy --noconfirm stow fzf ripgrep starship zoxide curl
else
    printf "%sError: No supported package manager found%s\n" "$RED" "$RESET"
    exit 1
fi

printf "%sInstalling latest Neovim from GitHub releases...%s\n" "$CYAN" "$RESET"

TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

NVIM_TARBALL="nvim-linux-$(uname -m | sed 's/aarch64/arm64/').tar.gz"
printf "%sDownloading %s...%s\n" "$CYAN" "$NVIM_TARBALL" "$RESET"

curl -LO "https://github.com/neovim/neovim/releases/latest/download/${NVIM_TARBALL}"

$SUDO tar -C /opt -xzf "$NVIM_TARBALL"
$SUDO ln -sf "/opt/nvim-linux-${NVIM_ARCH}/bin/nvim" /usr/local/bin/nvim

cd - > /dev/null
rm -rf "$TEMP_DIR"

touch "$HOME/dotfiles/nvim/lua/custom.lua"

stow -R .
ln -sf "$HOME/dotfiles/.bashrc" ~/.bashrc

printf "%s✓ Dotfiles installed successfully%s\n" "$GREEN" "$RESET"
