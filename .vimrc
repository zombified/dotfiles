execute pathogen#infect()

set nocompatible                " only vim feaures (no legacy vi features)
syntax enable                   " syntax highlighting, yay!
set encoding=utf-8              " default file encoding
set showcmd                     " display incomplete commands
filetype plugin indent on       " load filetype plugins + indentation
set hidden                      " keeps buffers in memory so a buffer doesn't need saving when switching between them


"" SPACING
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is 4 spaces ...
set softtabstop=4               " ...
set shiftwidth=4                " ...
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode
set autoindent


"" SEARCHING
set hlsearch            " highlight search results
set incsearch           " incremental searching
set ignorecase          " searches are case insensitive, ...
set smartcase           " ... unless they contain one or more capital letters


"" UI
if has('gui_running')               " Mac/GVim Settings
    set guioptions=aAce                     " git rid of the menu, toolbar, and scrollbar
    set transparency=2                      " just a hint of transparency
    colorscheme darkspectrum
else                                " Terminal Settings
    colors wombat256mod
    set colorcolumn=80                      " column 80 gets highlighted ...
    highlight ColorColumn ctermbg=0       " ... this color
endif


"" FILETYPE MAPPINGS
au BufRead *.zcml set filetype=xml
