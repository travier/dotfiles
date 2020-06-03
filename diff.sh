#!/usr/bin/env bash

# Stop if any command returns a non-zero value including when piping commands
set -e
set -o pipefail

vimdiff2() {
	if [ ${#} -ne 2 ]; then
		exit 1
	fi
	if [ ! -e "${1}" ]; then
		cp -i "${2}" "${1}"
		return
	fi

	if [ -n "$(diff "${1}" "${2}")" ]; then
		vimdiff "${1}" "${2}"
	fi
}

update_file() {
	local prefix=""
	if [ ${#} -ne 1 ]; then
		if [ ${#} -ne 2 ]; then
			exit 1
		fi
		prefix="${2}/"
	fi
	local filename="${1}"

	vimdiff2 "${HOME}/.${prefix}${filename}" "${prefix}${filename}"
}

for f in 'bashrc' 'zshrc' 'gitconfig' 'tmux.conf' 'vimrc' 'colordiffrc'; do
	update_file ${f}
done

for f in shell/*.{sh,bash,zsh}; do
	update_file "$(basename "${f}")" "shell"
done

mkdir -p "${HOME}/.config/git"
vimdiff2 'gitignore' "${HOME}/.config/git/ignore"
