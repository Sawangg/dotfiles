#!/bin/sh

DIRS="$HOME/Documents $HOME/personal $HOME/work"
CURRENT_SESSION=$(zellij ls -n | grep '(current)' | awk '{print $1}')
SESSION_LIST=$(zellij list-sessions -n | awk '{print $1}' | sort | grep -vx "$CURRENT_SESSION")
DIR_PATHS=$(find $DIRS -mindepth 1 -maxdepth 1 -type d -o -type l -xtype d 2>/dev/null | sort)

DIRS_WITHOUT_SESSION=""
for DIR in $DIR_PATHS; do
  TITLE=$(basename "$DIR")
  if ! echo "$SESSION_LIST" | grep -qx "$TITLE" && [ "$TITLE" != "$CURRENT_SESSION" ]; then
    DIRS_WITHOUT_SESSION="$DIRS_WITHOUT_SESSION$DIR
"
  fi
done

if [ -z "$SESSION_LIST" ] && [ -z "$DIRS_WITHOUT_SESSION" ]; then
  printf "\033[0;31mNo directories or sessions found\033[0m" >&2
  sleep 3
  exit 1
fi

CHOICE=$(
  { printf "%s\n" $SESSION_LIST
    printf "%s" "$DIRS_WITHOUT_SESSION"
  } | fzf --reverse \
          --info inline \
          --bind "ctrl-d:execute-silent(zellij delete-session -f {})+abort" \
          --header="Enter: switch, Ctrl-D: delete"
)

if [ -z "$CHOICE" ]; then
  exit 1
fi

if echo "$SESSION_LIST" | grep -qx "$CHOICE"; then
  zellij pipe --plugin https://github.com/mostafaqanbaryan/zellij-switch/releases/download/0.2.1/zellij-switch.wasm -- "-s=${CHOICE} -l custom"
else
  SESSION_TITLE=$(basename "$CHOICE")
  zellij --session "$SESSION_TITLE" --cwd "$CHOICE" --detach
  zellij pipe --plugin https://github.com/mostafaqanbaryan/zellij-switch/releases/download/0.2.1/zellij-switch.wasm -- "-s=${SESSION_TITLE} -c=${CHOICE} -l custom"
fi
