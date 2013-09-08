# File where the history is stored
export HISTFILE="$HOME/.shell/history/zsh"

# Entries in hitsory file
export SAVEHIST=5000
# Entries in internal history
export HISTSIZE=5000

setopt appendhistory nomatch
# Ignore duplicates
setopt hist_ignore_dups
setopt hist_ignore_all_dups
# Ignore commands with a leading space
setopt hist_ignore_space
# Search in history show matching lines only one time
setopt hist_find_no_dups
# Remove unnecessary blanks in history
setopt hist_reduce_blanks

# Using !cmd does not execute the command right away
setopt hist_verify

# Log time information in history
setopt extended_history

# Share history between zsh sessions
#setopt share_history

