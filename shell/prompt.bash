RED="\e[1;31m"
GREEN="\e[1;32m"
OFF="\e[0m"

function exit_status {
	local EXITSTATUS="$?"

	if [ "${EXITSTATUS}" -ne "0" ]
	then
		echo -e "|${RED}${EXITSTATUS}${OFF}\$ "
	fi
}

function git_status {
	local GIT_STATUS="$(__git_ps1 %s)"

	if [ -n "${GIT_STATUS}" ]
	then
		echo -e "${GREEN}@${GIT_STATUS}${OFF}"
	fi
}

if [ `whoami` = "root" ]; then
	PS1='\w$(git_status)$(exit_status)${RED}# '
else
	PS1='\w$(git_status)$(exit_status)\$ '
fi

