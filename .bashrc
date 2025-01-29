# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

complete -cf doas

# Aliases
alias cat='bat'
alias ls='lsd'
alias tree='ls --tree'
alias grep='grep --color=auto'
alias cd='z'
alias sudo='doas'
alias yay='yay --sudo doas --sudoflags -- --save'
alias vim='nvim'
alias v='nvim'
alias neofetch='fastfetch'
alias open='xdg-open'
alias k='kubecolor'
alias suspend='echo mem | doas /usr/bin/tee /sys/power/state > /dev/null'
alias hibernate='echo disk | doas /usr/bin/tee /sys/power/state > /dev/null'

# Eval some apps
eval "$(atuin init bash)"
eval "$(zoxide init bash)"
eval "$(starship init bash)"

# Env variables
export STARSHIP_CONFIG=~/.config/starship/starship.toml
