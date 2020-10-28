RED="\e[1;31m"
GREEN="\e[1;32m"
OFF="\e[0m"

function __exit_status {
	local EXITSTATUS="${?}"
	if [[ "${EXITSTATUS}" -ne "0" ]]; then
		echo -e "|${RED}${EXITSTATUS}${OFF}\$ "
	fi
}

function __git_ps1 {
	local b
	b="$(git symbolic-ref HEAD 2>/dev/null)";
	if [[ -n "${b}" ]]; then
		printf "%s" "${b##refs/heads/}";
	fi
}

function __git_status {
	local status
	status="$(__git_ps1 %s)"
	if [[ -n "${status}" ]]; then
		echo -e "${GREEN}@${status}${OFF}"
	fi
}

PS1=""

if [[ -n "${SSH_CLIENT}" ]]; then
	PS1='\u@\H:'
fi

if [[ "$(cat /etc/hostname)" == 'toolbox' ]]; then
	PS1="📦${PS1}"
fi

PS1=${PS1}'$(__git_status)$(__exit_status)\$ '
