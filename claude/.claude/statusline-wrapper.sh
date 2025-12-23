#!/bin/bash

# Read JSON input once
input=$(cat)

# Get git info from existing script
git_info=$(echo "$input" | bash ~/.claude/statusline-command.sh)

# Calculate context percentage
used=$(echo "$input" | sed -n 's/.*"total_input_tokens":\([0-9]*\).*/\1/p')
max=$(echo "$input" | sed -n 's/.*"context_window_size":\([0-9]*\).*/\1/p')

if [ -n "$used" ] && [ -n "$max" ] && [ "$max" -gt 0 ]; then
  pct=$(awk "BEGIN {printf \"%.1f\", ($used/$max)*100}")
  pct_int=$(awk "BEGIN {printf \"%d\", ($used/$max)*100}")
else
  pct="0.0"
  pct_int=0
fi

# Nord colors based on percentage (no bold for normal state)
NORD_SNOW='\033[38;2;216;222;233m'      # #D8DEE9 - normal (dimmer)
NORD_YELLOW='\033[1;38;2;235;203;139m'  # #EBCB8B - warning
NORD_RED='\033[1;38;2;191;97;106m'      # #BF616A - critical
RESET='\033[0m'

if [ "$pct_int" -ge 85 ]; then
  COLOR="$NORD_RED"
elif [ "$pct_int" -ge 70 ]; then
  COLOR="$NORD_YELLOW"
else
  COLOR="$NORD_SNOW"
fi

echo -ne "${git_info} | ${COLOR}${pct}%${RESET}"
