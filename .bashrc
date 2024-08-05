# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

complete -cf doas

# Aliases
alias cat='bat'
alias e='exit'
alias ls='lsd'
alias tree='ls --tree'
alias grep='grep --color=auto'
alias cd='z'
alias sudo='doas'
alias yay='yay --sudo doas --sudoflags -- --save'
alias v='nvim'
alias neofetch='fastfetch'
alias open='xdg-open'
alias k='kubecolor'

# Eval some apps
eval "$(atuin init bash)"
eval "$(zoxide init bash)"
eval "$(starship init bash)"
#eval "$(ssh-agent)"

# Env variables
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
export EDITOR=nvim
# pnpm
export PNPM_HOME="/home/leo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
