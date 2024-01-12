# Check for an interactive session
[ -z "$PS1" ] && return
# Or: [[ $- != *i* ]] && return

# Force SHELL to be bash
SHELL=/bin/bash

# Source global definitions
if [ -f /etc/profile ]; then
	source /etc/profile
fi
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# Source all generic and bash specific config from ~/.shell
for conf in `ls ~/.shell/*.sh ~/.shell/*.bash`; do
	source ${conf}
done
unset conf

shopt -s autocd
shopt -s cdspell
shopt -s nocaseglob

set show-all-if-ambiguous on
