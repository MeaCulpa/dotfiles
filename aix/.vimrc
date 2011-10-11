""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -jyxu- xujinyu@cn.ibm.com

" default encoding
let &termencoding = &encoding
set encoding=utf-8

" Wrap too long lines
set nowrap

" wrap words at 70
" set textwidth=70

" Tabs are 4 characters
set tabstop=4
set expandtab
set expandtab ts=4 sw=4 ai


" (Auto)indent uses 4 characters
set shiftwidth=4

" spaces instead of tabs
set expandtab

" guess indentation
set autoindent

" Expand the command line using tab
set wildchar=<Tab>

" show line numbers
set number

" prints number
set printoptions=number:y

" Fold using markers {{{
" like this
" }}}
set foldmethod=marker

" enable all features
set nocompatible

" powerful backspaces
set backspace=indent,eol,start

" highlight the searchterms
set hlsearch

" jump to the matches while typing
set incsearch

" ignore case while searching
set ignorecase

" history
set history=100

" 1000 undo levels
set undolevels=1000

" show a ruler
set ruler

" show partial commands
set showcmd

" show matching braces
set showmatch

" write before hiding a buffer
set autowrite

" shift = 4
set shiftwidth=4

" allows hidden buffers to stay unsaved, but we do not want this, so comment
" it out:
"set hidden

" auto-detect the filetype
filetype plugin indent on

" syntax highlight
syntax on

" abbrevations
ab #d #define
ab #i #include
ab #b /******************************
ab #e <space>******************************/
ab #l /*------------------------------*/

" we use a dark background, don't we?
set bg=dark

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif
