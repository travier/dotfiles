" Drop vi compatibility
set nocompatible

" Use pathogen
call pathogen#infect()

" Force 256 colors support
set t_Co=256

" Use plugin and syntax highlight
filetype plugin on
filetype indent on
syntax on

" Use PowerLine plugin
let g:Powerline_symbols='fancy'
" Config with no special font, reseted with :PowerlineClearCache
"let g:Powerline_symbols = 'compatible'
let g:Powerline_colorscheme = 'solarized256'
set laststatus=2
set encoding=utf-8

" Use solarized color theme
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Do not use modelines, use the securemodelines plugin instead
set nomodeline

let mapleader = ","
let g:mapleader = ","

" Use 'jk' instead of <Esc> to leave insert mode
inoremap jk <Esc>
"inoremap <Esc> <Nop>

" Use U for undo instead of C-r
noremap U <C-r>

" Do not use <file>~ or .swap as backup
set directory=~/.vim/backup,/tmp,/var/tmp
" Or just remove backups
"set nobackup
"set noswapfile

" Set .viminfo file location
set viminfo+=n~/.vim/viminfo

" Set undodir options
set undodir=~/.vim/undodir
set undofile
set undolevels=100 "maximum number of changes that can be undone
set undoreload=100 "maximum number lines to save for undo on a buffer reload

set history=200

" Ignore files with specific extensions
set suffixes=.jpg,.png,.jpeg,.gif,.bak,~,.swp,.swo,.o,.info,.aux,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo

" Enable en_US spellcheck
setlocal spell spelllang=en_us

" Autoreload files
set autoread

"set hidden
set more
set title
set showcmd
set scrolloff=10
set sidescrolloff=5
set wildmenu
set wildignore=*.o,*~,*.pyc,*.swp,*.bak
set lazyredraw
set fileformats=unix,dos,mac
set ttyfast

" No bells
set noerrorbells
set novisualbell

" Textwidth options
"set textwidth=79

" Do not wrap lines.
"set nowrap

highlight ColorColumn ctermbg=235 guibg=#262626
set colorcolumn=80

" Disabled as I'm not using quickfixsigns plugin yet.
"highlight SignColumn ctermbg=234 guibg=#262626

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=240 guibg=#585858
match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$\| \+\ze\t/
match ExtraWhitespace /[^\t]\zs\t\+/

" Show tabs and trailing spaces
set list listchars=tab:»\ ,trail:·

" Linenumber options
set cursorline
set number " or relativenumber
set ruler

" Indent/space options:
" Number of spaces that a <Tab> in the file counts for
set tabstop=8
" Number of spaces to use for each step of (auto)indent
set shiftwidth=8
" Use the appropriate number of spaces to insert a <Tab>
"set expandtab
" Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode. This
" is a list of items, separated by commas. Each item allows a way to backspace
" over something.
set backspace=indent,eol,start
" Copy indent from current line when starting a new line (typing <CR> in Insert
" mode or when using the "o" or "O" command).
set autoindent
" Do smart autoindenting when starting a new line. Works for C-like programs,
" but can also be used for other languages.
set smartindent

" Search related options:
" Use <CR> to stop search highlight
nnoremap <CR> :nohlsearch<CR><CR>
" When there is a previous search pattern, highlight all its matches.
set hlsearch
" While typing a search command, show immediately where the so far typed
" pattern matches.
set incsearch
" Ignore case in search patterns.
set ignorecase
" Override the 'ignorecase' option if the search pattern contains upper case
" characters.
set smartcase

" Folding related options:
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=0

" This is a sequence of letters which describes how automatic formatting is to
" be done.
"
" letter    meaning when present in 'formatoptions'
" ------    ---------------------------------------
" c         Auto-wrap comments using textwidth, inserting the current comment
"           leader automatically.
" q         Allow formatting of comments with "gq".
" r         Automatically insert the current comment leader after hitting
"           <Enter> in Insert mode.
" t         Auto-wrap text using textwidth (does not apply to comments)
set formatoptions=c,q,r,t

" Show matching bracets when text indicator is over them
set showmatch
" How many tenths of a second to blink
set matchtime=2

" Enable mouse support
set mouse-=a
set mousehide

" Easily toggle paste
set pastetoggle=<F2>

" Save a file you forgot to open with sudo
cmap w!! w !sudo tee % >/dev/null

" Python PEP 8 support
autocmd FileType python set expandtab softtabstop=4 tabstop=4 shiftwidth=4

" LaTeX support
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
autocmd FileType tex set shiftwidth=2 tabstop=2
" Set spellcheck locally
"autocmd FileType tex setlocal spell spelllang=fr
"autocmd FileType tex setlocal spell spelllang=en_US

set complete=.,w,b,u,U,t,i,d

