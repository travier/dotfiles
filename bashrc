# Check for an interactive session
[ -z "$PS1" ] && return
# Or: [[ $- != *i* ]] && return

# umask 027

# Bash history control
HISTSIZE=20000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups

# Basic aliases
alias l='ls --color=auto'
alias ls='ls --color=auto'
alias ll='ls --color=auto --all -l --human-readable'
#alias ldir='ls -l| egrep "^d"'
alias c='cd'
alias ..='cd ..'
alias du='du --human-readable'
alias df='df --human-readable'
alias grep='grep --color=auto'
alias gr='grep -Rn --color=auto'
alias gdb='gdb --quiet'
alias v='vim'
alias vi='vim'
alias vimrc='vim ~/.vimrc'
alias bashrc='vim ~/.bashrc'

#function example_func {
#	grep --color=auto -Rn $@ *.[ch]
#}
#export -f example_func

source /usr/share/git/completion/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

# Définis la ligne de prompt
# PS1='[\u@\h \W]\$ '
# User in green color: \[\e[1;32m\]\u\[\e[m\]
# Working directory: \[\e[1;34m\]\w\[\e[m\] or \W
#PS1="\w${GREEN}$(__git_ps1 "@%s")${OFF}$ "
#PS1="\`RC=\$?; echo -n '\w${GREEN}$(__git_ps1 "@%s")'; if [ \$RC != 0 ]; then echo -n '${RED}\$${OFF} '; else echo -n '${OFF}\$ '; fi\`"
#PS1="[\`RC=\$?; if [ \$RC = 0 ]; then echo ${GREEN}${PASS_SMILEY}${WHITE}; elif [ \$RC = 139 ]; then echo ${RED}${SEGV_SMILEY}${WHITE}; else echo ${RED}${FAIL_SMILEY}${WHITE}; fi\`]$OLDPS1"
#PS1='\w\[\e[1;32m\]\[\e[0m\]$ '

function parse_git_dirty {
	[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "⚡"
}

function parse_git_branch {
	local b="$(git branch --no-color 2> /dev/null | sed --expression='/^[^*]/d' --expression='s/^* //')"
	if [ -n "$b" ] && [ "$b" = "(no branch)" ]; then
		local b="$(git name-rev --name-only HEAD 2> /dev/null)"
	fi

	if [ -n "$b" ]; then
		printf "@$b$(parse_git_dirty)"
	fi
}

__git_ps1 () {
	local b="$(git symbolic-ref HEAD 2>/dev/null)";
	if [ -n "$b" ]; then
		printf "@%s" "${b##refs/heads/}";
	fi
}

RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
OFF="\[\e[0m\]"

function exitstatus {
        EXITSTATUS="$?"

        if [ "$EXITSTATUS" -eq "0" ]
        then
                PS1="\w${GREEN}$(__git_ps1)${OFF}$ "
        else
                PS1="\w${GREEN}$(__git_ps1)${OFF}|${RED}$EXITSTATUS${OFF}\$ "
        fi
}

PROMPT_COMMAND=exitstatus

# Add some environment variables
export GREP_COLOR="1;33"
export EDITOR="vim"

# Firefox hack, should be checked
export MOZ_DISABLE_PANGO=1

shopt -s autocd
shopt -s cdspell

set show-all-if-ambiguous on

# Colored man
man() {
		env \
			LESS_TERMCAP_mb=$(printf "\e[1;31m") \
			LESS_TERMCAP_md=$(printf "\e[1;31m") \
			LESS_TERMCAP_me=$(printf "\e[0m") \
			LESS_TERMCAP_se=$(printf "\e[0m") \
			LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
			LESS_TERMCAP_ue=$(printf "\e[0m") \
			LESS_TERMCAP_us=$(printf "\e[1;32m") \
					man "$@"
	}

function set_ruby {
	export PATH="/home/timothee/.gem/ruby/1.9.1/bin:$PATH"
}

