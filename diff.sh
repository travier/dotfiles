#!/usr/bin/env bash

# Stop if any command returns a non-zero value including when piping commands
set -e
set -o pipefail

function update_file() {
	local prefix=""
	if [ ${#} -ne 1 ]; then
		if [ ${#} -ne 2 ]; then
			exit 1
		fi
		prefix="${2}/"
	fi
	local filename="${1}"

	if [ ! -e "${HOME}/.${prefix}${filename}" ]; then
		cp -i "${prefix}${filename}" "${HOME}/.${prefix}${filename}"
		return
	fi

	if [ -n "$(diff "${HOME}/.${prefix}${filename}" "${prefix}${filename}")" ]; then
		vimdiff "${HOME}/.${prefix}${filename}" "${prefix}${filename}"
	fi
}

for f in 'bashrc' 'zshrc' 'ackrc' 'gitconfig' 'tmux.conf' 'vimrc' 'tigrc' 'colordiffrc' 'latexmkrc'; do
	update_file ${f}
done

for f in shell/*.{sh,bash,zsh}; do
	update_file "$(basename "${f}")" "shell"
done
