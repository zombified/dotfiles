"set transparency=2          " a very light amount of transparency
set guioptions=aAce        " get's rid of the menu, toolbar and scrollbar junk
set guioptions-=mT
"colorscheme PaperColor
"let g:airline_theme='PaperColor'
colorscheme Tomorrow-Night
"colorscheme darkspectrum
"colorscheme molokai
"set background=light
"colorscheme solarized
" highlight color of the colorcolumn in the GUI
highlight ColorColumn guibg=#363636
set guifont=Source\ Code\ Pro\ for\ Powerline:h12
"set guifont=Source\ Code\ Pro:h12
"set guifont=Fira\ Mono\ Medium:h11
"set guifont=M\+\ 2m\ regular:h10

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END


