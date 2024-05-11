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
#eval "$(ssh-agent)"

# Start tmux
if [ -z "$TMUX" ]; then
    tmux new-session
fi

# Display the current git branch if part of a repository
parse_git_branch() {
    local branch_name
    branch_name=$(git branch 2>/dev/null | sed -n '/^\*/s/^\* //p')
    if [ -n "$branch_name" ]; then
        echo -e " \e[38;2;203;166;247m( $branch_name)"
    else
        echo ""
    fi
}

export PS1='\e[38;2;116;199;236m\W$(parse_git_branch) \e[38;2;166;227;161m❱\e[0m '

# pnpm
export PNPM_HOME="/home/leo/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
