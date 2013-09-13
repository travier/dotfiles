# Set colors
autoload -U colors && colors

# Allow functions in prompt
setopt PROMPT_SUBST

RED="%{$fg[red]%}"
GREEN="%{$fg[green]%}"
OFF="%{$reset_color%}"

function exit_status {
	local EXITSTATUS="$?"

	if [ "${EXITSTATUS}" -ne "0" ]
	then
		echo "${RED}%?${OFF}|"
	fi
}

function git_status {
	local GITSTATUS="$(__git_ps1 %s)"

	if [ -n "${GITSTATUS}" ]
	then
		echo "${GREEN}${GITSTATUS}${OFF}|"
	fi
}

if [ `whoami` = "root" ]; then
	PROMPT="${RED}#${OFF} "
else
	PROMPT="${GREEN}\$${OFF} "
fi

#RPROMPT='$(exitstatus)$(git_status)%n@%m:%~|%T'
RPROMPT='$(exit_status)$(git_status)%~'

