" default encoding
set encoding=utf8

" GVim font
set guifont=youyuan:h12:cGB2312

" default color scheme
" colorscheme torte

" Wrap too long lines
set nowrap

" wrap words at 75
set textwidth=75

" Treate Chinese
set formatoptions+=mM

" Auto insert line-breaks for txt and mail file.
au BufEnter *.txt setl tx ts=4 sw=4 fo+=n2a
au BufEnter *.mail setl tx ts=4 sw=4 fo+=n2a

" Tabs are 4 characters
set tabstop=4

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
"set bg=dark

" Always show the menu, insert longest match
set completeopt=menuone,longest

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

"
" twitvim settings
" http://www.vim.org/scripts/script.php?script_id=2204
"
let twitvim_login = "methuselar:XXXXXX"

" switch between twitter and identica login
function! Switch_to_twitter()
    let g:twitvim_api_root = "http://twitter.com"
    let g:twitvim_login = "methuselar:XXXXXX"
    FriendsTwitter
endfunction

function! Switch_to_identica()
    let g:twitvim_api_root = "http://identi.ca/api"
    let g:twitvim_login = "meaculpa:XXXXXX"
    FriendsTwitter
endfunction

command! ToTwitter :call Switch_to_twitter()
command! ToIdentica :call Switch_to_identica()

let twitvim_proxy = "191.168.11.3:3128"
let twitvim_count = 129
let twitvim_browser_cmd="firefox"
nnoremap <F8> :FriendsTwitter<cr>


"
" twitvim plugins
"
let twitvim_enable_python = 1
let twitvim_enable_perl = 0
"LET TWITvim_enable_ruby = 1
"let twitvim_enable_tcl = 1

"
" vimim settings
" http://www.vim.org/scripts/script.php?script_id=2506
"
let g:vimim_one_key=1
let g:vimim_chinese_input_mode=1

" ctAGS
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 50
map <F4> :TlistToggle<cr>

" pydiction
let g:pydiction_location = '/home/inferno/.vim/after/ftplugin/pydiction/complete-dict'

"---------------------------------------------------------
"Neo Complete Settings
"See: http://www.vim.org/scripts/script.php?script_id=2620
"---------------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
