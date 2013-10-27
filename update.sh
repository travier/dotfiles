#!/bin/bash

pushd ~/.vim/bundle

for b in `ls`; do
	cd $b
	echo "[+] Updating $b"
	git pull origin
	cd ..
done

popd

./diff.sh
