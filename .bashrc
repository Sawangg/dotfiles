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
alias kctx='kubectl config use-context $(kubectl config get-contexts -o name | fzf)'
alias suspend='echo mem | doas /usr/bin/tee /sys/power/state > /dev/null'
alias hibernate='echo disk | doas /usr/bin/tee /sys/power/state > /dev/null'
alias update='doas pacman -Syu && yay -Syu'
alias aws-profile='export AWS_PROFILE=$(sed -n "s/\[\(.*\)\]/\1/gp" ~/.aws/credentials | fzf)'

# Fzf theme
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F38BA8 \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#6C7086,label:#CDD6F4"

# Eval some apps
eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(atuin init bash)"
