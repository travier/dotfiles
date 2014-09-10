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

" Config for Powerline plugin
set laststatus=2

set encoding=utf-8

" Change supertab bindings
let g:SuperTabMappingForward = '<s-c-@>'
let g:SuperTabMappingBackward = '<c-@>'

" Use solarized color theme
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Do not use modelines, use the securemodelines plugin instead
set nomodeline

"let mapleader = ","
"let g:mapleader = ","
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Fix inconsistent Y mapping
nnoremap Y y$

" Use 'jk' in addition of <Esc> to leave insert mode
inoremap jk <Esc>

" Use U for undo instead of C-r
nnoremap U <C-r>
" Close quickfix window
nnoremap <leader>c :ccl<CR>
" Use tpope dispatch Make
nnoremap <leader>m :Make<CR>
" Update the view in diff mode
nnoremap <leader>d :diffupdate<CR>
" Various shortcuts
nnoremap <leader>w :w<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>s :SudoWrite<CR>

" Map <Plug>SearchPartyHighlightClear to avoid conflict
nmap <leader><CR> <Plug>SearchPartyHighlightClear

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q vipgq

" Remove arrow keys mapping
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" More natural movement with long line
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Use ranger as vim file manager
function! RangeChooser()
	" Get a temporary filename without creating it
	let temp = tempname()
	" Launch ranger, passing it the temp file name
	exec 'silent !ranger --choosefiles=' . shellescape(temp)
	" If the temp file has not been written by ranger
	if !filereadable(temp)
		" Nothing to read.
		redraw!
		return
	endif
	let names = readfile(temp)
	if empty(names)
		" Nothing to open.
		redraw!
		return
	endif
	" Edit the first item.
	exec 'edit ' . fnameescape(names[0])
	" Add any remaning items to the arg list/buffer list.
	for name in names[1:]
		exec 'argadd ' . fnameescape(name)
	endfor
	redraw!
endfunction

command! -bar RangerChooser call RangeChooser()

" Set ranger bindings
nnoremap <leader>r :<C-U>RangerChooser<CR>
nnoremap <leader>v :vs<CR>:<C-U>RangerChooser<CR><C-w>L

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
set suffixes=.aux,.bak,.bbl,.blg,.brf,.cb,.dvi,.gif,.idx,.ilg,.ind,.info,.inx,.jpeg,.jpg,.o,.out,.pdf,.png,.pyc,.pyo,.swo,.swp,.toc,~

" Enable en_US spellcheck and use function keys to change spelllang
setlocal spell spelllang=en_us
noremap <F3> :setlocal spell spelllang=en_us<CR>
noremap <F4> :setlocal spell spelllang=fr<CR>
noremap <F5> :setlocal nospell<CR>

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

" Jump back to the last edit position when opening a file
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Python PEP 8 support
autocmd FileType python set expandtab softtabstop=4 tabstop=4 shiftwidth=4

" Rust support
autocmd FileType rust set expandtab softtabstop=4 tabstop=4 shiftwidth=4

" LaTeX support
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_MultipleCompileFormats='dvi,pdf'
autocmd FileType tex set shiftwidth=2 tabstop=2

" Web related options
autocmd FileType html set expandtab softtabstop=2 tabstop=2 shiftwidth=2 foldmethod=manual
autocmd FileType css set expandtab softtabstop=2 tabstop=2 shiftwidth=2
autocmd FileType javascript set expandtab softtabstop=2 tabstop=2 shiftwidth=2

set complete=.,w,b,u,U,t,i,d
