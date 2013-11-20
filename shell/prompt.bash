RED="\e[1;31m"
GREEN="\e[1;32m"
OFF="\e[0m"

function __exit_status {
	local EXITSTATUS="$?"

	if [ "${EXITSTATUS}" -ne "0" ]
	then
		echo -e "|${RED}${EXITSTATUS}${OFF}\$ "
	fi
}

function __git_status {
	local GIT_STATUS="$(__git_ps1 %s)"

	if [ -n "${GIT_STATUS}" ]
	then
		echo -e "${GREEN}@${GIT_STATUS}${OFF}"
	fi
}

unset PS1

if [ -n "${SSH_CLIENT}" ]; then
	PS1='\u@\H:'
fi

PS1=${PS1}'\w$(__git_status)$(__exit_status)\$ '
