#!/bin/bash

pushd ~/.vim/bundle

for b in `ls`; do
	cd $b
	echo "[+] Updating $b"
	git pull origin
	cd ..
done

popd

pushd ~/.shell

for d in "zsh-syntax-highlighting"; do
	cd $d
	echo "[+] Updating $d"
	git pull origin
	cd ..
done

popd

./diff.sh
