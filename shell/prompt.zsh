# Set colors
autoload -U colors && colors

# Allow functions in prompt
setopt PROMPT_SUBST

RED="%{$fg[red]%}"
GREEN="%{$fg[green]%}"
OFF="%{$reset_color%}"

function __exit_status {
	local EXITSTATUS="$?"

	if [ "${EXITSTATUS}" -ne "0" ]
	then
		echo "${RED}%?${OFF}|"
	fi
}

function __git_status {
	local GITSTATUS="$(__git_ps1 %s)"

	if [ -n "${GITSTATUS}" ]
	then
		echo "${GREEN}${GITSTATUS}${OFF}|"
	fi
}

unset PROMPT

if [ -n "${SSH_CLIENT}" ]; then
	PROMPT='%n@%M:'
fi

PROMPT=${PROMPT}"${GREEN}\$${OFF} "
RPROMPT='$(__exit_status)$(__git_status)%~|%T'
