#!/usr/bin/env bash

# Stop if any command returns a non-zero value including when piping commands
set -e
set -o pipefail

pushd ~/.vim/bundle

for b in *; do
	pushd "${b}"
	printf "[+] Updating %s\n" "${b}"
	git pull origin
	popd
done

popd

pushd ~/.shell

for d in "zsh-syntax-highlighting"; do
	if [[ -d ${d} ]]; then
		pushd "${d}"
		printf "[+] Updating %s\n" "${d}"
		git pull origin
		popd
	fi
done

popd

./diff.sh
