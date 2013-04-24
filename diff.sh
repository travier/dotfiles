#!/bin/bash

vimdiff ~/.bashrc bashrc
vimdiff ~/.zshrc zshrc
for conf in `ls ~/.shell/ | grep "\.sh"`; do
	vimdiff ~/.shell/${conf} shell/${conf}
done
for conf in `ls ~/.shell/ | grep "\.bash"`; do
	vimdiff ~/.shell/${conf} shell/${conf}
done
for conf in `ls ~/.shell/ | grep "\.zsh"`; do
	vimdiff ~/.shell/${conf} shell/${conf}
done
vimdiff ~/.ackrc ackrc
vimdiff ~/.gitconfig gitconfig
vimdiff ~/.tmux.conf tmux.conf
vimdiff ~/.vimrc vimrc

