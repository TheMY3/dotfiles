#!/usr/bin/env bash

# Orange workspace number where a Claude Code session waits for you (finished or asks).
#   claude_attention.sh mark|clear  — from Claude Code hooks (Stop/Notification, UserPromptSubmit/SessionEnd), hook JSON on stdin
#   claude_attention.sh             — sketchybar plugin (claude_attention, aerospace_workspace_change)

STATE_DIR="$HOME/.cache/claude-attention"
TERMINAL_APP="Ghostty"
CONFIG_DIR="${CONFIG_DIR:-$HOME/.config/sketchybar}"
PATH="/opt/homebrew/bin:$PATH"

terminal_workspaces() {
  aerospace list-windows --all --format '%{workspace}|%{app-name}' 2>/dev/null \
    | awk -F'|' -v app="$TERMINAL_APP" '$2 == app {print $1}' | sort -u
}

case "$1" in
  mark | clear)
    session=$(jq -r '.session_id // empty' 2>/dev/null)
    [ -n "$session" ] || exit 0
    mkdir -p "$STATE_DIR"
    if [ "$1" = "mark" ]; then
      # Already looking at the terminals — nothing to flag
      focused=$(aerospace list-workspaces --focused 2>/dev/null)
      terminal_workspaces | grep -qx "$focused" && exit 0
      touch "$STATE_DIR/$session"
    else
      rm -f "$STATE_DIR/$session"
    fi
    sketchybar --trigger claude_attention >/dev/null 2>&1
    exit 0
    ;;
esac

source "$CONFIG_DIR/colors.sh"

# Entering the terminal workspace counts as seen
if [ "$SENDER" = "aerospace_workspace_change" ] && terminal_workspaces | grep -qx "$AEROSPACE_FOCUSED_WORKSPACE"; then
  rm -f "$STATE_DIR"/* 2>/dev/null
fi

focused=${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}
waiting=$(ls -A "$STATE_DIR" 2>/dev/null)

for sid in $(terminal_workspaces); do
  if [ -n "$waiting" ]; then
    sketchybar --set space.$sid icon.color=$ORANGE label.color=$ORANGE background.border_color=$ORANGE
  else
    # Back to the look space.sh / space_windows.sh give focused and other workspaces
    border=$BACKGROUND_2
    [ "$sid" = "$focused" ] && border=$GREY
    sketchybar --set space.$sid icon.color=$ICON_COLOR label.color=$GREY background.border_color=$border
  fi
done
