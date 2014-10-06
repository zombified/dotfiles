"" GENERAL CONFIGURATION
" uncomment to watch .vimrc so settings are automatically reloaded
"au BufWritePost .vimrc so $MYVIMRC

" let pathogen take care of all plugin loading
execute pathogen#infect()

set textwidth=0
set nocompatible                " only vim feaures (no legacy vi features)
syntax enable                   " syntax highlighting, yay!
set encoding=utf-8              " default file encoding
set showcmd                     " display incomplete commands
filetype on                     " try to detect filetypes
filetype plugin indent on       " load filetype plugins + indentation
set hidden                      " keeps buffers in memory so a buffer doesn't need saving when switching between them
set laststatus=2                " always show statusline

" store swap files in fixed location
if isdirectory($HOME . '/.vim/swap') == 0
    :silent !mkdir -p ~/.vim/swap > /dev/null 2>&1
endif
set dir=~/.vim/swap//,/var/tmp/vimswap/,/tmp/vimswap/,.

" turn on and set the directory for persistent undo's if the option exists
if exists("+undoofile")
    if isdirectory($HOME . '/.vim/undo') == 0
        :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
    endif
    set undodir=~/.vim/undo//,./.vim-undo/,.
    set undofile
endif

" make vim show relative numbers when the window is out of focus, or when
" out of insert mode
au FocusLost * :set number
au FocusGained * :set relativenumber
au InsertEnter * :set number
au InsertLeave * :set relativenumber


"" KEYBINDINGS
let mapleader = ","             " change from '\' to ','

" switch to previous buffer with ',,'
nnoremap <Leader><Leader> <c-^>

" strip all whitespace at end of file with ',<space>'
"nnoremap <Leader>W :%s/\s\+$//<cr>:let @/=''<CR>
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
map <Leader>n :NERDTreeToggle<CR>


"" SPACING
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is 4 spaces ...
set softtabstop=4               " ...
set shiftwidth=4                " ...
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode
set autoindent
set autowrite                   " auto save when switching buffers

" highlight EOL spaces
set list
set listchars=tab:>.,trail:.


"" SEARCHING
set hlsearch                    " highlight search results
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive, ...
set smartcase                   " ... unless they contain one or more capital letters


"" UI
set nu                          " show line numbers
set colorcolumn=80              " column 80 gets highlighted
"if has('gui_running')
"    set background=light
"else
"    set background=dark
"endif
set background=light
let g:solarized_termtrans = 1
"colorscheme solarized
colorscheme Tomorrow-Night-Bright
" highlight color of column in terminal
"highlight ColorColumn ctermbg=238
highlight clear SignColumn

" this will disable the short pause when leaving insert mode in the terminal
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif


"" FILETYPE OPTIONS
" for making zcml's read as xml
au BufRead *.zcml set filetype=xml

" for making md read as markdown
au BufRead *.md set filetype=markdown

" disable autoindent on <Return> in html files
au FileType html setl indentkeys-=*<Return>

" set spell check and autowrap text in emails
au FileType mail set spell spelllang=en_us fo+=aw

" set folding method for python files
au FileType python set foldmethod=indent


"" PLUGIN OPTIONS
" NERDTree (https://github.com/scrooloose/nerdtree) - drawer style file browser
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=2
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" netrw (built in)
"map <Leader>n :e.<CR>

" signify (https://github.com/mhinz/vim-signify) - shows lines that have been added, changed, and removed based on vcs feedback
let g:signify_vcs_list = [ 'git', 'hg' ]

" vaxe: https://github.com/jdonaldson/vaxe - provides haxe stuff
" vinegar (git clone https://github.com/tpope/vim-vinegar.git) - provides some nice configuration and additions to netrw
" airline (git clone https://github.com/bling/vim-airline) - vimscript powerline
" syntastic (git clone https://github.com/scrooloose/syntastic.git) - provides syntax checking for various languages
" pyflakes-pathogen (git clone https://github.com/mitechie/pyflakes-pathogen.git) - provides python syntax checking
" recover: https://github.com/chrisbra/Recover.vima - add 'Diff' option when opening file with a swp file already existing
" solarized  color scheme: https://github.com/altercation/vim-colors-solarized

