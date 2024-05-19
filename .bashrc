# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias e='exit'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias cd='z'
alias sudo='doas'
alias yay='yay --sudo doas --sudoflags -- --save'
alias vim='nvim'
alias neofetch='fastfetch'

# Eval some apps
eval "$(zoxide init bash)"
eval "$(starship init bash)"
#eval "$(ssh-agent)"

# Start tmux
if [ -z "$TMUX" ]; then
    tmux new-session
fi

export STARSHIP_CONFIG=~/.config/starship/starship.toml

