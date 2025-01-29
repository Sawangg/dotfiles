#
# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start Hyprland if there is no process called Hyprland
if ! pgrep -x "Hyprland" > /dev/null; then
    Hyprland
fi
