#!/bin/sh

# Open lazygit with support for bare repo + worktree setups.
# Handles three cases:
#   1. Normal clone       → run lazygit directly
#   2. Inside a worktree  → pass --git-dir and --work-tree to lazygit
#   3. Bare repo root     → cd into the best worktree, then launch lazygit

if [ -d .git ]; then
  exec lazygit
fi

if [ -f .git ] && grep -q 'gitdir:' .git 2>/dev/null; then
  git_dir=$(git rev-parse --git-dir 2>/dev/null)
  work_tree=$(git rev-parse --show-toplevel 2>/dev/null)

  if [ -n "$git_dir" ] && [ -n "$work_tree" ]; then
    exec lazygit --git-dir="$git_dir" --work-tree="$work_tree"
  fi
fi

if [ -d .bare ] || [ "$(git rev-parse --is-bare-repository 2>/dev/null)" = "true" ]; then
  # Try preferred branches first (master, then main)
  for branch in master main; do
    if [ -d "$branch" ]; then
      git_dir=$(git -C "$branch" rev-parse --git-dir 2>/dev/null)
      work_tree=$(git -C "$branch" rev-parse --show-toplevel 2>/dev/null)

      if [ -n "$git_dir" ] && [ -n "$work_tree" ]; then
        cd "$branch" && exec lazygit --git-dir="$git_dir" --work-tree="$work_tree"
      fi
    fi
  done

  # Fallback: pick the first worktree that isn't the bare repo itself
  wt=$(git worktree list --porcelain 2>/dev/null |
    grep '^worktree ' |
    sed 's/^worktree //' |
    grep -v "$(pwd)" |
    head -1)

  if [ -n "$wt" ]; then
    git_dir=$(git -C "$wt" rev-parse --git-dir 2>/dev/null)
    cd "$wt" && exec lazygit --git-dir="$git_dir" --work-tree="$wt"
  fi

  echo "No worktree found. Create one first with: git worktree add <name> <branch>"
  sleep 3
  exit 1
fi

exec lazygit
