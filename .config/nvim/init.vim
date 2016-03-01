call plug#begin('~/.config/nvim/pluggged')

  " git diff indicators
  Plug 'airblade/vim-gitgutter'

  " nice info bar
  Plug 'bling/vim-airline'

  " error checking/linting
  Plug 'benekastah/neomake'

  " netrw enhancement
  Plug 'tpope/vim-vinegar'

  " fuzzy file/buffer/etc matchet and opener
  Plug 'ctrlpvim/ctrlp.vim'

  " file-drawer style navigation
  "Plug 'scrooloose/nerdtree'

  " colors/syntax for ansible
  Plug 'pearofducks/ansible-vim'

  " options and automatic handling for swapfile recovery
  Plug 'chrisbra/Recover.vim'

call plug#end()


filetype on                 " enable file type detection
filetype plugin indent on   " enable per-file type indentation
syntax enable               " default syntax highlight enabled 

" backspace through everything in insert mode
set backspace=indent,eol,start    

set textwidth=0             " lines pasted as-is, not split to a max width
set encoding=utf-8          " it's 2016, this should be the default now.
set showcmd                 " display partial command info (lines selected, etc)
set hidden                  " keep buffers in memory
set laststatus=2            " always show status line
set ruler                   " show location info in status line
set wildmenu                " show completions when <Tab>ing in the command line
set scrolloff=1             " num lines above and below cursor to be shown always
set sidescrolloff=5         " num cols left and right of cursor to be shown always
set display+=lastline       " show as much of really long lines as possible
set autoread                " automatically reload files changed outside of nvim
set history=1000            " keep 1000 lines of command history
set hlsearch                " highlight search results
set incsearch               " skip to first match immediately when searching
set ignorecase              " searches are case insensitive...
set smartcase               " ...unless the search contains capital letters
set nu                      " show line numbers

set autoindent              " indent based on previous indentation
set smarttab                " insert tabs based on previous indentation
set complete-=i             " disable scanning includes to complete (rely on ctags, etc -- faster)
set nowrap                  " don't wrap lines
set tabstop=4               " a tab is 4 spaces...
set softtabstop=4           " ...
set shiftwidth=4            " ...
set expandtab               " use spaces, not tabs
set autowrite               " autosave when switching buffers


" characters to highlight in 'list' mode (and enable list mode by default)
set listchars=tab:>.,trail:.
set list


" show relative numbers when window out of focus and not in insert mode
au FocusLost * :set number
au FocusGained * :set relativenumber
au InsertEnter * :set number
au InsertLeave * :set relativenumber


" store swap files in a fixed location, makes management a lot easier
" and doesn't clutter up a source directory
if isdirectory($HOME . '/.config/nvim/swap') == 0
  :silent !mkdir -p $HOME/.config/nvim/swap > /dev/null 2>&1
endif
set dir=$HOME/.config/nvim/swap/,/var/tmp/nvimswap/,/tmp/nvimswap,.

" turn on and set the directory for persistent undo's (if the option exists)
if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p $HOME/.config/nvim/undo > /dev/null 2>&1
endif
set undodir=$HOME/.config/nvim/undo/,./.vim-undo/,.
set undofile


colorscheme Tomorrow-Night-Eighties
" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" reset sign column display
highlight clear SignColumn

" highlight current line
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" higlight column 80
set colorcolumn=80        " highlight column 80


" == KEY REBINDING ============================================================

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

" toggle nerdtree with ',n'
"map <Leader>n :NERDTreeToggle<CR>


" == FILE TYPE OPTIONS ========================================================

" for making zcml's read as xml
au BufRead *.zcml set filetype=xml

" for making md read as markdown
au BufRead *.md set filetype=markdown

" disable autoindent on <Return> in html files
au FileType html setl indentkeys-=*<Return>

" set folding method, etc for python files
" my defaults are for 4 spaces, but I like being certain...
au BufNewFile,BufRead *.py set tabstop=4
au BufNewFile,BufRead *.py set softtabstop=4
au BufNewFile,BufRead *.py set shiftwidth=4
au BufNewFile,BufRead *.py set expandtab
au BufNewFile,BufRead *.py set autoindent
au BufNewFile,BufRead *.py set fileformat=unix

" html, js, and css tend to use 2 spaces... which is stupid, but whatever,
" it's used more often than not so might as well play nice
au BufNewFile,BufRead *.html,*.css,*.js set tabstop=2
au BufNewFile,BufRead *.html,*.css,*.js set softtabstop=2
au BufNewFile,BufRead *.html,*.css,*.js set shiftwidth=2
au BufNewFile,BufRead *.html,*.css,*.js set expandtab

" nim should be inteded with 2 spaces
au FileType nim setlocal shiftwidth=2 tabstop=2


" == PLUGIN OPTIONS ===========================================================

" neomake
autocmd! BufWritePost * Neomake

" syntastic -- use flake8 for checking python
"let g:syntastic_python_checkers = ['flake8']

" ctrlp
" -- ignore searching certain directories
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" -- use cwd unless current file is outside cwd
let g:ctrlp_working_path_mode = 'wa'

" vim:set ft=vim et sw=2:
