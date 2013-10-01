#!/bin/bash

ORIGIN_WD=$PWD

cd ~/.vim/bundle
for b in `ls`; do 
	cd $b
	echo "[+] Updating $b"
	git pull origin
	cd ..
done

cd "${ORIGIN_WD}"
./diff.sh
