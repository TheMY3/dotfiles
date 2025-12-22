# Initialize Starship prompt
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set default editor to Neovim
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"

# Set a compatible terminal type if xterm-kitty is not supported
export TERM=xterm-256color

# History settings

# Set the file where command history is saved
HISTFILE=~/.history

# Number of commands to keep in memory
HISTSIZE=10000

# Number of commands to save to HISTFILE
SAVEHIST=50000

# Append commands to history file as they are executed
setopt inc_append_history

# bindkey '\e[A' history-search-backward
# bindkey '\e[B' history-search-forward

# Load history-substring-search
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Enable history search with up/down arrows
bindkey '\e[A' up-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search


# Function to determine the main branch (main or master)
git_main_branch() {
  git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@'
}

# ALIASES

alias cc='claude'

alias nf='fzf -m --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'

# Git aliases

# Shortcut for git command
alias g='git'

# Show diff
alias gd='git diff'

# Show branches
alias gb='git branch'

# Show short status
alias gss='git status -s'

# Add all changes
alias gaa='git add --all'

# Amend last commit with changes
alias gca!='git commit --verbose --all --amend'

# Commit all changes
alias gca='git commit -a'

# Commit all changes with message
alias gcam='git commit -a -m'

# Create and switch to a new branch
alias gcb='git checkout -b'

# Switch branches
alias gco='git checkout'

# Pull latest changes from the current branch
alias ggl='git pull origin $(git rev-parse --abbrev-ref HEAD)'

# Push current branch
alias ggp='git push origin $(git rev-parse --abbrev-ref HEAD)'

#Push with force-with-lease to prevent overwriting other's work
alias ggf='git push origin $(git rev-parse --abbrev-ref HEAD) --force-with-lease'

# Rebase onto the main branch
alias grbm='git rebase $(git_main_branch)'

# Switch to the main branch
alias gcm='git checkout $(git_main_branch)'

# Delete a branch
alias gbd='git branch --delete --force'

# Show a pretty git log with graph and decoration
alias glo='git log --oneline --decorate'

# Docker Compose v2 aliases

# Start services in detached mode
alias dcup='docker compose up'

# Stop and remove containers, networks, volumes
alias dcdn='docker compose down'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/home/my/.local/bin:$PATH"
