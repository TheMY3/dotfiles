#!/bin/bash
# https://www.aihero.dev/creating-the-perfect-claude-code-status-line
# Nord palette true color codes

NORD_CYAN='\033[1;38;2;136;192;208m'     # #88C0D0 - Frost cyan
NORD_BLUE='\033[1;38;2;129;161;193m'     # #81A1C1 - Frost blue
NORD_GREEN='\033[1;38;2;163;190;140m'    # #A3BE8C - Aurora green
NORD_ORANGE='\033[1;38;2;208;135;112m'   # #D08770 - Aurora orange
NORD_YELLOW='\033[1;38;2;235;203;139m'   # #EBCB8B - Aurora yellow
RESET='\033[0m'

input=$(cat)
cwd=$(echo "$input" | sed -n 's/.*"current_dir":"\([^"]*\)".*/\1/p')

if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  repo_name=$(echo "$cwd" | sed "s|^$HOME/Websites/||")
  branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
  staged=$(git -C "$cwd" --no-optional-locks diff --cached --name-only 2>/dev/null | wc -l)
  unstaged=$(git -C "$cwd" --no-optional-locks diff --name-only 2>/dev/null | wc -l)
  untracked=$(git -C "$cwd" --no-optional-locks ls-files --others --exclude-standard 2>/dev/null | wc -l)

  printf "${NORD_CYAN}%s${RESET} | ${NORD_BLUE}%s${RESET} | S: ${NORD_GREEN}%s${RESET} | U: ${NORD_ORANGE}%s${RESET} | A: ${NORD_YELLOW}%s${RESET}" \
    "$repo_name" "$branch" "$staged" "$unstaged" "$untracked"
else
  printf "${NORD_CYAN}%s${RESET}" "$cwd"
fi
