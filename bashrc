# Check for an interactive session
[ -z "$PS1" ] && return
# Or: [[ $- != *i* ]] && return

# Source all generic and bash specific config from ~/.shell
for conf in `ls ~/.shell/*.sh ~/.shell/*.bash`; do
	source ${conf}
done

shopt -s autocd
shopt -s cdspell

set show-all-if-ambiguous on

