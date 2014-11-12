# Set colors
autoload -U colors && colors

# Allow functions in prompt
setopt PROMPT_SUBST

__RED="%{$fg[red]%}"
__GREEN="%{$fg[green]%}"
__OFF="%{$reset_color%}"
__VIMMODE="\$"

function __exit_status {
	local EXITSTATUS="${?}"

	if [ "${EXITSTATUS}" -ne "0" ]
	then
		echo "${__RED}%?${__OFF}|"
	fi
}

function __git_ps1 {
	local b="$(git symbolic-ref HEAD 2>/dev/null)";
	if [ -n "${b}" ]; then
		printf "%s" "${b##refs/heads/}";
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

# Set VIMMODE variable to $ in insert mode and § in command mode
function zle-line-init zle-keymap-select {
	__VIMMODE="${${KEYMAP/vicmd/⚡}/(main|viins)/\$}"
	zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

PROMPT=${PROMPT}${__GREEN}'${__VIMMODE}'${__OFF}" "
RPROMPT='$(__exit_status)$(__git_status)%~|%T'
