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
audioctx() {
  local status_output=$(wpctl status)
  local current_default=$(echo "$status_output" | awk '
    /Sinks:/{f=1}
    /Sources:/{f=0}
    f && /\*/ { match($0, /[0-9]+\./); print substr($0, RSTART+RLENGTH); exit }
  ')
  local selected_sink=$(echo "$status_output" | awk '
    /Sinks:/{f=1}
    /Sources:/{f=0}
    f && /\./ && !/\*/ {
      match($0, /[0-9]+\./)
      print substr($0, RSTART, RLENGTH-1) "\t" substr($0, RSTART+RLENGTH)
    }
  ' | fzf --header "Current: $current_default" | cut -f1)
  [ -n "$selected_sink" ] || return
  wpctl set-default "$selected_sink"
  local sink_name=$(wpctl list audio sinks | awk -F'\t' '$1=="'"$selected_sink"'" {print $2}')
  local sink_ids=$(wpctl list audio sinks | awk -F'\t' '{print $1}' | jq -R tonumber | jq -s -c .)
  for stream_id in $(pw-dump Link 2>/dev/null | jq -r --argjson sink_ids "$sink_ids" '
    .[]? | (.info?.props?["link.input.node"] // empty) as $in
    | select(($sink_ids | index($in)) != null)
    | .info?.props?["link.output.node"]
  ' | sort -u); do
    pw-metadata -n default "$stream_id" target.object "$sink_name" >/dev/null 2>&1
  done
}

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
export VISUAL=nvim
export EDITOR=nvim
export DIFFPROG="nvim -d"
export MANPAGER="nvim +Man!"
export MANWIDTH=999
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
