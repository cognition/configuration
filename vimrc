"" (C) 2021
"" Ramon Brooker
"" rbrooker@aeo3.io

" vim-plug


set nocompatible
filetype indent on
filetype plugin on


syntax enable
syntax on

set history=10000
set guioptions+=a
set hidden
set wildmenu
set showcmd

set hlsearch        " highlight searches
set incsearch       " highlight as you type
set ignorecase
set smartcase

set backspace=indent,eol,start
set bs=2
set autoindent

set nostartofline
set ruler
set laststatus=3
set confirm

set visualbell t_vb=
set mouse=a

set cmdheight=3
set number

set notimeout ttimeout ttimeoutlen=200

set shiftwidth=4
set softtabstop=4
set expandtab

map Y y$

nnoremap <leader>E :vsplit $MYVIMRC<cr>
nnoremap <C-L> :nohl<CR><C-L>

set showmatch
set encoding=utf-8
set ls=2


set visualbell
set modelines=0
set ls=2         " always show status line"
set listchars=tab:▸\ ,eol:¬

" get rid of the funny symbols in tmuxline"
let g:tmuxline_powerline_separators = 0

" Vim-Rainbow"
let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']


" Lightline Vim"
set laststatus=2


