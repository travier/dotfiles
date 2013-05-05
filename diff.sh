#!/bin/bash

function update_file() {
	local prefix=""
	if [ ${#} -ne 1 ]; then
		if [ ${#} -ne 2 ]; then
			exit 1
		fi
		prefix="${2}/"
	fi
	local filename="${1}"

	if [ -n "`diff ~/.${prefix}${filename} ${prefix}${filename}`" ]; then
		vimdiff ~/.${prefix}${filename} ${prefix}${filename}
	fi
}

for f in 'bashrc' 'zshrc' 'ackrc' 'gitconfig' 'tmux.conf' 'vimrc'; do
	update_file ${f}
done

for f in `ls shell | grep "\.sh"; ls shell | grep "\.bash"; ls shell | grep "\.zsh"`; do
	update_file ${f} "shell"
done

