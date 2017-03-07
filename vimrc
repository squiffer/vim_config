set nocompatible 
filetype off 

set modeline " allow special comments to run vim commands
syntax on

" highlight search matches
set hlsearch

" line numbering
set nu
set hidden

" convert tabs to spaces, etc
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set ai "auto indent
set cindent "c indent
set wrap "wrap lines

" mouse support
set mouse=a
set ttymouse=xterm2 " 2 gives full mouse support
set ttyfast " enable faster mouse updating

" allow backspace to delete all characters in insert mode
set bs=2

" keep selection when indenting/unindenting in visual mode
" Note: The 0 is to keep the cursor at the start of the bottom line
vnoremap < <gv0  
vnoremap > >gv0 

map <F2> :NERDTreeToggle<CR>
map <F3> :GundoToggle<CR>
" easily close buffer without closing window
" command defined in bufkill.vim
map <F4> :Bclose<CR>

" map copy/paste from CLIPBOARD buffer on Linux
" * is the SELECTION buffer
map <F6> "+y
map <F7> "+p

" NOTE: values that are too low for timeoutlen will prevent the
" leader key from working (100 ms is about the lower limit of
" what can be pressed consistently)
set timeoutlen=500
set ttimeoutlen=50

" code folding settings
set fdc=1 " fold column

set listchars=tab:▸\ 
set listchars=tab:▸\ 

colorscheme molokai
"let g:molokai_original = 1
"let g:rehash256 = 1
set background=dark
highlight Comment cterm=bold
"override the background setting in the theme
highlight Normal ctermbg=NONE

set laststatus=2

" Get rid of separator char on splits
set fillchars+=vert:\  
highlight VertSplit ctermbg=DarkGray
