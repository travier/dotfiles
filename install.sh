#!/bin/bash

# Use any argument to bypass this check
E_BADARGS=65
if [ ${#} -ne 1 ]; then
	echo "READ ME before blindly launching me!!"
	exit ${E_BADARGS}
fi

# Vim setup
rm -rf ~/.vim
mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/backup ~/.vim/undodir

# Install pathogen plugin
curl -Sso ~/.vim/autoload/pathogen.vim \
	https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

pushd ~/.vim/bundle/

# Open a file and go to specified line using <filename>:<line>
git clone https://github.com/bogado/file-line.git

# fugitive.vim: a Git wrapper so awesome, it should be illegal
git clone https://github.com/tpope/vim-fugitive.git

# snipMate.vim aims to be a concise vim script that implements some of
# TextMate's snippets features in Vim
git clone https://github.com/garbas/vim-snipmate.git
# snipMate dependencies
git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
git clone https://github.com/honza/vim-snippets.git

# Vim Markdown runtime files
git clone https://github.com/tpope/vim-markdown.git

# Vim Git runtime files
git clone https://github.com/tpope/vim-git.git

# precision colorscheme for the vim text editor
git clone https://github.com/altercation/vim-colors-solarized.git

# A secure alternative to Vim modelines
git clone https://github.com/ciaranm/securemodelines.git

# commentary.vim: comment stuff out
git clone https://github.com/tpope/vim-commentary.git

# dispatch.vim: asynchronous build and test dispatcher
git clone https://github.com/tpope/vim-dispatch.git

# eunuch.vim: helpers for UNIX
git clone https://github.com/tpope/vim-eunuch.git

# Extended search commands and maps for Vim
git clone https://github.com/dahu/SearchParty.git

# Find a char across lines
git clone https://github.com/dahu/vim-fanfingtastic.git

# Mark quickfix & location list items with signs
#git clone https://github.com/tomtom/quickfixsigns_vim.git

# repeat.vim: enable repeating supported plugin maps with "."
git clone https://github.com/tpope/vim-repeat.git

# Syntax checking hacks for vim
git clone https://github.com/scrooloose/syntastic.git

# A fancy start screen for Vim
git clone https://github.com/mhinz/vim-startify

# surround.vim: quoting/parenthesizing made simple
git clone https://github.com/tpope/vim-surround.git

# Vim plugin for the Perl module / CLI script 'ack'
git clone https://github.com/mileszs/ack.vim.git

# Rust support
git clone https://github.com/wting/rust.vim.git

popd

# Shell setup
rm -rf ~/.shell
mkdir -p ~/.shell/history

pushd ~/.shell/

curl -Sso dircolors.256dark \
	https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark

git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

popd

./diff.sh

echo "Install the following packages (Arch Linux):"
echo "vim-spell-en vim-spell-fr vim-doxygentoolkit vim-supertab vim-systemd"
echo "From the AUR:"
echo "python2-powerline-git"
