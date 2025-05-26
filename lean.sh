#!/bin/sh

#
# THIS SCRIPT SHOULD ONLY BE USED INSIDE A CONTAINER
#

check_command() {
  type "$1" > /dev/null 2>&1
}

install_packages() {
    if [ $# -eq 0 ]; then
        printf "Error: No packages specified for installation\n" >&2
        return 1
    fi

    case "$PACKAGE_MANAGER" in
        "apt-get")
            apt-get install -y "$@"
            ;;
        "apk")
            apk add "$@"
            ;;
        "yum")
            yum install -y "$@"
            ;;
        "dnf")
            dnf install -y "$@"
            ;;
        "pacman")
            pacman -Sy --noconfirm "$@"
            ;;
        *)
            printf "Error: Unsupported package manager '%s'\n" "$PACKAGE_MANAGER" >&2
            return 1
            ;;
    esac
}

PACKAGE_MANAGER=""

if check_command apt-get; then
    apt-get update
    PACKAGE_MANAGER="apt-get"
elif check_command apk; then
    apk update
    PACKAGE_MANAGER="apk"
elif check_command yum; then
    PACKAGE_MANAGER="yum"
elif check_command dnf; then
    PACKAGE_MANAGER="dnf"
elif check_command pacman; then
    PACKAGE_MANAGER="pacman"
else
    printf "No supported package manager found. Exiting...\n"
    exit 1
fi

install_packages stow nvim

stow -R .

printf "Installed the dotfiles successfully.\n"
