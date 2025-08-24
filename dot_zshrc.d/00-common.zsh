# Common ZSH Configuration
# This file contains settings that are common across all machines
# Loaded first (00-*) to ensure basic settings are available

# History configuration
# Set history file location and size
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# History options
setopt HIST_IGNORE_DUPS          # Don't record duplicate entries
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_SPACE         # Don't record entries starting with space
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks
setopt HIST_VERIFY               # Show command with history expansion before running
setopt SHARE_HISTORY             # Share history between all sessions
setopt EXTENDED_HISTORY          # Write timestamps to history file
setopt INC_APPEND_HISTORY        # Append to history file immediately

# Directory navigation options
setopt AUTO_CD                   # Change directory without 'cd'
setopt AUTO_PUSHD                # Push directories to stack
setopt PUSHD_IGNORE_DUPS         # Don't push duplicates to directory stack
setopt PUSHD_SILENT              # Don't print directory stack after pushd/popd

# Completion options
setopt COMPLETE_IN_WORD          # Complete from both ends of word
setopt ALWAYS_TO_END             # Move cursor to end after completion
setopt MENU_COMPLETE             # Show completion menu on first tab press
setopt AUTO_LIST                 # Automatically list choices on ambiguous completion
setopt AUTO_REMOVE_SLASH         # Remove trailing slash when completing directories

# Other useful options
setopt INTERACTIVE_COMMENTS      # Allow comments in interactive shell
setopt NO_BEEP                   # Don't beep on errors
setopt NO_HUP                    # Don't send HUP signal to background jobs on exit
setopt CHECK_JOBS                # Check for running jobs before exit

# Key bindings
# Use Emacs-style key bindings (most common)
bindkey -e

# Additional useful key bindings
bindkey '^[[A' history-search-backward  # Up arrow for history search
bindkey '^[[B' history-search-forward   # Down arrow for history search
bindkey '^R' history-incremental-search-backward  # Ctrl+R for incremental search

# Terminal title
# Set terminal title to current directory
precmd() {
    print -Pn "\e]0;%~\a"
}

# Welcome message (optional)
# Uncomment to show a welcome message
# echo "Welcome to ZSH! Loaded common configuration."