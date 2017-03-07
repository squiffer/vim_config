set nocompatible 

" Sets how many lines of history VIM has to remember
set history=500

set modeline " allow special comments to run vim commands
syntax on

filetype plugin on
filetype indent on

call plug#begin()
Plug 'sentientmachine/Pretty-Vim-Python'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
"Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim'}
call plug#end()

" Set to auto read when a file is changed from the outside
"set autoread

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
"command W w !sudo tee % > /dev/null
"command W w !dzdo tee % > /dev/null

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Always show current position
"set ruler

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" highlight search matches
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
"set lazyredraw 

" For regular expressions turn magic on
"set magic

" Show matching brackets when text indicator is over them
set showmatch 

" No annoying sound on errors
set noerrorbells
"set novisualbell
"set t_vb=
"set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" line numbering
set nu
set hidden

" convert tabs to spaces, etc
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
"set lbr
"set tw=500

set ai "auto indent
set cindent "c indent
set wrap "wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
" FIXME: consider using the real Bclose
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

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

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>
" Quickly open a buffer for scribble (modifed from orig)
" make a "savetmp" function?
map <leader>q :enew<cr>

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
" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

" Get rid of separator char on splits
set fillchars+=vert:\  
highlight VertSplit ctermbg=DarkGray


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Make VIM remember position in file after reopen
if has("autocmd")
   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
