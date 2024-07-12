# If not running interactively, don't do anything
[[ $- != *i* ]] && return

complete -cf doas

# Aliases
alias e='exit'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cd='z'
alias sudo='doas'
alias yay='yay --sudo doas --sudoflags -- --save'
alias vim='nvim'
alias neofetch='fastfetch'
alias open='xdg-open'

# Eval some apps
eval "$(zoxide init bash)"
eval "$(starship init bash)"
#eval "$(ssh-agent)"

# Env variables
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export EDITOR=nvim
# pnpm
export PNPM_HOME="/home/leo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
