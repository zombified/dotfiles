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


"" KEYBINDINGS
let mapleader = ","             " change from '\' to ','

" toggle NERDTree with ',n'
map <Leader>n :NERDTreeToggle<CR>

" open CtrlP with 'ctrl-p'
let g:ctrlp_map = '<c-p>'

" switch to previous buffer with ',,'
nnoremap <Leader><Leader> <c-^>

" jump to next pep8 violation with ',8'
let g:pep8_map='<Leader>8'

" strip all whitespace at end of file
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
inoremap jj <Esc>


"" SPACING
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is 4 spaces ...
set softtabstop=4               " ...
set shiftwidth=4                " ...
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode
set autoindent

" highlight EOL spaces
set list
set listchars=trail:.

"" SEARCHING
set hlsearch                    " highlight search results
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive, ...
set smartcase                   " ... unless they contain one or more capital letters


"" UI
set colorcolumn=80                  " column 80 gets highlighted
colors wombat256mod
" highlight color of column in terminal
highlight ColorColumn ctermbg=238


"" FILETYPE MAPPINGS
au BufRead *.zcml set filetype=xml


"" PLUGIN OPTIONS
" NERDTree (https://github.com/scrooloose/nerdtree) - provides file browser
    " this will quit even if the only buffer is NERDTree asdfalasdfasdf asd fas dfa sdf asdf
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" pyflakes (https://github.com/mitechie/pyflakes-pathogen) - provides python pep8 syntax checking

" CtrlP (https://github.com/kien/ctrlp.vim) - provides fuzzy filename search
    " ignore irrelevant files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.pyo
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Ack (https://github.com/mileszs/ack.vim) - provides recursive in-file search
let g:ackprg="/opt/local/bin/ack-5.12 -H --nocolor --nogroup --column"

