set nocompatible 
filetype off 

" if rope is set with jedi-vim, completion is extremely slow
""" python-mode config
let g:pymode_rope=0

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
"set si "smart indent
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
"map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
"map <F4> :Bclose<CR>
" map copy/paste from CLIPBOARD buffer on Linux
" * is the SELECTION buffer
map <F6> "+y
map <F7> "+p

" fix alt key
" fix meta-keys which generate <Esc>a .. <Esc>z
" NOTE: this needs the ttimeoutlen set in order to not conflict
"  with the escape key
" WARNING: Screws up macros
"let c='a'
"while c <= 'z'
  "exec "set <A-".c.">=\e".c
  "exec "imap \e".c." <A-".c.">"
  "let c = nr2char(1+char2nr(c))
"endw

" NOTE: values that are too low for timeoutlen will prevent the
" leader key from working (100 ms is about the lower limit of
" what can be pressed consistently)
set timeoutlen=500
set ttimeoutlen=50

" code folding settings
set fdc=1 " fold column
"set fdl=1 " fold level

set listchars=tab:▸\ 
set listchars=tab:▸\ 

"Bundle 'tomasr/molokai'
"Bundle 'molokai'
colorscheme molokai
"let g:molokai_original = 1
"let g:rehash256 = 1
set background=dark
highlight Comment cterm=bold
"override the background setting in the theme
highlight Normal ctermbg=NONE

set laststatus=2
"let g:airline_theme='molokai'
let g:airline_theme='dark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
" Get rid of separator char on splits
set fillchars+=vert:\  
highlight VertSplit ctermbg=DarkGray

"" Fix the space issue
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"
"
"let g:airline#extensions#tabline#enabled = 1

""" python-mode config
let g:pymode_rope = 0


" The below is disabled as it makes everything go dark when calling =(
" Set the executable bit on a file without reloading the buffer
" from: http://vim.wikia.com/wiki/Setting_file_attributes_without_reloading_a_buffer 
"function! SetExecutableBit()
"  let fname = expand("%:p")
"  checktime
"  execute "au FileChangedShell " . fname . " :echo"
"  silent !chmod a+x %
"  checktime
"  execute "au! FileChangedShell " . fname
"endfunction
"command! Xbit call SetExecutableBit()
