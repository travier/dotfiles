#!/bin/bash

# Use any argument to bypass this check
E_BADARGS=65
if [ $# -ne 1 ]; then
	echo "READ ME before blindly launching me!!"
	exit $E_BADARGS
fi

cp vimrc ~/.vimrc
cp vimrc ~/.bashrc

