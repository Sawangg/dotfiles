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
    $SUDO apt-get install -y stow fzf neovim ripgrep starship zoxide
elif command -v apk > /dev/null 2>&1; then
    printf "%sUsing package manager: %sapk%s\n" "$CYAN" "$BOLD" "$RESET"
    $SUDO apk update
    $SUDO apk add stow fzf neovim ripgrep starship zoxide
elif command -v pacman > /dev/null 2>&1; then
    printf "%sUsing package manager: %spacman%s\n" "$CYAN" "$BOLD" "$RESET"
    $SUDO pacman -Sy --noconfirm stow fzf neovim ripgrep starship zoxide
else
    printf "%sError: No supported package manager found%s\n" "$RED" "$RESET"
    exit 1
fi

stow -R .
ln -sf "$HOME/dotfiles/.bashrc" ~/.bashrc

printf "%s✓ Dotfiles installed successfully%s\n" "$GREEN" "$RESET"
