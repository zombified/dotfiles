set nocompatible	    " let vim be vim

call plug#begin('~/.vim/plugged')

    " infobar! yay!
    Plug 'vim-airline/vim-airline'

    " options and automatic handling for swapfile recovery
    Plug 'chrisbra/Recover.vim'

    " git integration and visualization
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'

    " syntax checking
    Plug 'scrooloose/syntastic'


    " ansible syntax for ansible-yaml, jinja2, and ansible-hosts
    Plug 'pearofducks/ansible-vim'

call plug#end()

colorscheme Tomorrow-Night-Eighties

filetype on                 " enable file type detection
filetype plugin indent on   " enable per-file type indentation
syntax enable               " default syntax highlight enabled 

set backspace=indent,eol,start  " backspace through everything in insert mode

set encoding=utf-8          " because it's not 1998
set hidden                  " keep buffers in memory
set nowrap                  " don't wrap lines
set autowrite               " autosave when switching buffers

set autoindent              " indent based on previous indentation
set smarttab                " insert tabs based on previous indentation
set expandtab               " use spaces, not tabs
set tabstop=4               " a tab is 4 spaces...
set softtabstop=4           " ...
set shiftwidth=4            " ...

set history=1000            " keep 1000 lines of command history
set hlsearch                " highlight search results
set incsearch               " skip to first match immediately when searching
set ignorecase              " searches are case insensitive...
set smartcase               " ...unless the search contains capital letters

set nu                      " show line numbers

set clipboard=unnamed       " copy/paste from clipboard without prepending '*' buffer name to commands


" show relative numbers when window out of focus and not in insert mode
au FocusLost * :set number
au FocusGained * :set relativenumber
au InsertEnter * :set number
au InsertLeave * :set relativenumber

set listchars=tab:>.,trail:.,extends:⇻,precedes:⇺    " 'list' mode character mappings
set list					     " always show 'list' mode


augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END


" store swap files in a fixed location, makes management a lot easier
" and doesn't clutter up a source directory
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p $HOME/.vim/swap > /dev/null 2>&1
endif
set dir=$HOME/.vim/swap/,/var/tmp/vimswap/,/tmp/vimswap,.

" turn on and set the directory for persistent undo's (if the option exists)
if isdirectory($HOME . '/.vim/undo') == 0
  :silent !mkdir -p $HOME/.vim/undo > /dev/null 2>&1
endif
set undodir=$HOME/.vim/undo/,./.vim-undo/,.
set undofile


" make leader key more handy
let mapleader = ","

" switch buffers with ',,'
nnoremap <Leader><Leader> <c-^>

" strip all whitespace at end of file with ',<space>'
function! <SID>StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespace()<CR>


au BufRead *.zcml set filetype=xml		" zcml == xml
au BufRead *.md set filetype=markdown		" .md == markdown

au FileType html setl indentkeys-=*<Return>	" html does not get autoindent-on-return

" html, js, and css tend to use 2 spaces... which is stupid, but whatever,
" it's used more often than not so might as well play nice
au BufNewFile,BufRead *.html,*.css,*.js set tabstop=2
au BufNewFile,BufRead *.html,*.css,*.js set softtabstop=2
au BufNewFile,BufRead *.html,*.css,*.js set shiftwidth=2
au BufNewFile,BufRead *.html,*.css,*.js set expandtab


" SYNTASTIC
" these are recommended, but pointless with vim-airline installed
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1  " enable by default, don't expect any clashes
let g:syntastic_auto_loc_list = 2             " auto close list, but not auto open
let g:syntastic_check_on_open = 1             " check on buffer save AND open
let g:syntastic_check_on_wq = 0               " don't check just before closing
let g:syntastic_python_checkers = ['flake8']  " for python, use flake8

" open error list on ',eo' sequence
nnoremap <Leader>e :lopen<Return>


" VIM-AIRLINE
let g:airline#extensions#syntastic#enabled = 1
