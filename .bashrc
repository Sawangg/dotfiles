# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# Aliases
alias cat='bat'
alias cd='z'
alias ls='lsd'
alias tree='ls --tree'
alias v='nvim'
alias vim='nvim'
alias lg='lazygit'
alias neofetch='fastfetch'
alias oc='opencode'

alias k='kubecolor'
alias kubectl='kubecolor'
kctx() { ctx=$(kubectl config get-contexts -o name | fzf) || return; [ -n "$ctx" ] && kubectl config use-context "$ctx"; }
aws-profile() { p=$(sed -n "s/\[\(.*\)\]/\1/gp" ~/.aws/credentials | fzf) || return; [ -n "$p" ] && export AWS_PROFILE="$p"; }

alias open='xdg-open'

alias update='doas pacman -Syyu && yay -Syyu'
alias suspend='echo mem | doas /usr/bin/tee /sys/power/state > /dev/null'
alias hibernate='echo disk | doas /usr/bin/tee /sys/power/state > /dev/null'

if command -v doas >/dev/null 2>&1; then
  complete -cf doas
  alias sudo='doas'
  alias yay='yay --sudo doas --sudoflags -- --save'
fi

# Env variables
export STARSHIP_CONFIG=~/.config/starship/starship.toml
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
