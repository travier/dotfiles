# Check for an interactive session
[ -z "$PS1" ] && return
# Or: [[ $- != *i* ]] && return

# Force SHELL to be bash
SHELL=/bin/bash

source /etc/profile

# Source all generic and bash specific config from ~/.shell
for conf in `ls ~/.shell/*.sh ~/.shell/*.bash`; do
	source ${conf}
done

shopt -s autocd
shopt -s cdspell

set show-all-if-ambiguous on
