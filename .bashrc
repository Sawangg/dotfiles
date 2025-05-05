# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

complete -cf doas

# Aliases
alias cat='bat'
alias cd='z'
alias ls='lsd'
alias tree='ls --tree'
alias sudo='doas'
alias yay='yay --sudo doas --sudoflags -- --save'
alias vim='nvim'
alias v='nvim'
alias neofetch='fastfetch'
alias open='xdg-open'
alias kubectl='kubecolor'
alias k='kubecolor'
alias suspend='echo mem | doas /usr/bin/tee /sys/power/state > /dev/null'
alias hibernate='echo disk | doas /usr/bin/tee /sys/power/state > /dev/null'

# Env variables
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export FZF_DEFAULT_OPTS='--color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f38ba8 --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 --color=selected-bg:#45475a'

# Eval some apps
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(atuin init bash)"
