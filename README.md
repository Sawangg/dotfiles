# Sawang's dotfiles

This is my dotfiles repository containing all of my configs. I tried to achieve a consistent workflow for development as well as trying to be the perfect blend between useful, secure and pretty. Here is a list of features:

- Minimalist & terminal focused, everything you need is inside the terminal
- Keyboard centric, move fast using the power of good mappings
- Full support for different keyboard layouts (`qwerty` & `azerty`)
- Consistent theme across all apps with soothing colors to limit eye strain
- Leaner version usable in devcontainers
- Compatible with `systemd` free distros like `Artix Linux`
- Only using open-source software

![screenshot](https://github.com/user-attachments/assets/2a6944c0-f293-4043-828a-7f855e5723b3)

## Install

You can simply run the following setup script to install my full config locally on your machine

```sh
sh <(curl -s "https://raw.githubusercontent.com/Sawangg/dotfiles/refs/heads/master/setup.sh")
```

> [!NOTE]
> This script will only be able to install packages automatically on Arch based distros

Or run all of your devcontainers with [DevPod](https://devpod.sh/) and the leaner dotfiles preinstalled

```sh
devpod context set-options -o DOTFILES_URL=https://github.com/Sawangg/dotfiles -o DOTFILES_SCRIPT=lean.sh
```
