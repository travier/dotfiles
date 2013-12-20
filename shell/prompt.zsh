# Set colors
autoload -U colors && colors

# Allow functions in prompt
setopt PROMPT_SUBST

__RED="%{$fg[red]%}"
__GREEN="%{$fg[green]%}"
__OFF="%{$reset_color%}"

function __exit_status {
	local EXITSTATUS="$?"

	if [ "${EXITSTATUS}" -ne "0" ]
	then
		echo "${__RED}%?${__OFF}|"
	fi
}

function __git_status {
	local GITSTATUS="$(__git_ps1 %s)"

	if [ -n "${GITSTATUS}" ]
	then
		echo "${__GREEN}${GITSTATUS}${__OFF}|"
	fi
}

unset PROMPT

if [ -n "${SSH_CLIENT}" ]; then
	PROMPT='%n@%M:'
fi

PROMPT=${PROMPT}"${__GREEN}\$${__OFF} "
RPROMPT='$(__exit_status)$(__git_status)%~|%T'
