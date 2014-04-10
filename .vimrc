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
"set noshowmode                  " hide the normal mode -- handled by powerline

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

" toggle NERDTree with ',n'
map <Leader>n :NERDTreeToggle<CR>

" open CtrlP with 'ctrl-p'
let g:ctrlp_map = '<c-p>'

" switch to previous buffer with ',,'
nnoremap <Leader><Leader> <c-^>

" jump to next pep8 violation with ',8'
"let g:pep8_map='<Leader>8'

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

" remate Esc or Ctrl-[ to jj
"inoremap jj <Esc>

" open a temporary buffer
map <Leader>. :Scratch<CR>

" open a temporary buffer in a split window
map <Leader>/ :Sscratch<CR>


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
if has('gui_running')
    set background=light
else
    set background=dark
endif
let g:solarized_termtrans = 1
colorscheme solarized
"colors molokai
"let g:molokai_original=1
" highlight color of column in terminal
highlight ColorColumn ctermbg=238
highlight clear SignColumn


"" FILETYPE OPTIONS
" for making zcml's read as xml
au BufRead *.zcml set filetype=xml

" disable autoindent on <Return> in html files
au FileType html setl indentkeys-=*<Return>

" set spell check and autowrap text in emails
au FileType mail set spell spelllang=en_us fo+=aw

" set folding method for python files
au FileType python set foldmethod=indent


"" PLUGIN OPTIONS
" NERDTree (https://github.com/scrooloose/nerdtree) - provides file browser
    " this will quit even if the only buffer is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeChDirMode=2
    " hide files with these extensions in NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" CtrlP (https://github.com/kien/ctrlp.vim) - provides fuzzy filename search
    " ignore irrelevant files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.pyo
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Ack (https://github.com/mileszs/ack.vim) - provides recursive in-file search
let g:ackprg="/opt/local/bin/ack-5.12 -H --nocolor --nogroup --column"

" vim-session (https://github.com/xolox/vim-session) - provides some handy session management features
let g:session_autosave='yes'
let g:session_autoload='yes'
let g:session_default_to_last='yes'

" vim-notes (https://github.com/xolox/vim-notes)
let g:notes_directories=['~/Documents/notes/']
let g:notes_suffix='.md'
let g:notes_title_sync='rename_file'
let g:notes_smart_quotes=0

" airline (git clone https://github.com/bling/vim-airline) - vimscript powerline
    " auto include powerline font symbols
"let g:airline_powerline_fonts = 1

    " this will disable the short pause when leaving insert mode in the terminal
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

" signify (https://github.com/mhinz/vim-signify) - shows lines that have been added, changed, and removed based on vcs feedback
let g:signify_vcs_list = [ 'git', 'hg' ]

" syntastic (git clone https://github.com/scrooloose/syntastic.git) - provides syntax checking for various languages
" molokai color scheme: https://github.com/tomasr/molokai
" solarized  color scheme: https://github.com/altercation/vim-colors-solarized
" vaxe: https://github.com/jdonaldson/vaxe - provides haxe stuff
" vim-misc: https://github.com/xolox/vim-misc.git
" recover: https://github.com/chrisbra/Recover.vim

