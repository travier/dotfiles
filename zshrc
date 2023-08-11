# Force SHELL to be zsh
SHELL=/bin/zsh

if [[ ! -f "/run/.containerenv" ]]; then
    toolbox enter "fedora-toolbox-38"
fi

# source /etc/zsh/zprofile

# Source all generic and zsh specific config from ~/.shell
for conf in `ls ~/.shell/*.sh ~/.shell/*.zsh`; do
	source ${conf}
done

# Print job status before exiting shell
setopt check_jobs
# No beeps
unsetopt beep
# Allow to comment lines in interactive shell
setopt interactive_comments
# Auto correct commands
setopt correct
# Ask for confirmation when removing files with '*'
unsetopt rm_star_silent
# Handle symbolic links in paths
setopt chase_dots
# Enable extended globing
setopt extendedglob
# When globing is used in an argument list, remove unmatched elements instead
# of outputting an error. Disabled to avoid unwanted side effects with 'ls'.
unsetopt nullglob

# Fish shell like syntax highlighting for Zsh
source ~/.shell/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath+=~/.shell/zsh_completions

# It seems like this one as to be done at the end
compinit

# Setup completion for aliases
compdef g='git'
compdef gi='git'
compdef gt='git'
compdef m='make'
compdef tm='tmux'

if [[ -n "$(command -v zoxide)" ]]; then
  _ZO_ECHO=1
  eval "$(zoxide init zsh)"
fi

# Additional completions
source <(~/.local/bin/kubectl completion zsh)
source <(~/.local/bin/oc completion zsh)
source <(~/.local/bin/gh completion -s zsh)

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/tim/projects/bin/terraform terraform
