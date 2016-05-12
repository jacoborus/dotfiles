"""""""""""""""""""""""""""""""""""""""""
" GENERAL
"""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
" enable true color in neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set nocompatible              " be iMproved

let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" change buffer
nmap <leader>bn :bn<cr>
nmap <leader>bp :bp<cr>

" Fast saving
nmap <leader>w :w<cr>

" fast copy to the end of the line
nmap Y y$

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" fast open/close quickfix
nmap <leader>lo :lopen<cr>
nmap <leader>lc :lcl<cr>

" fast launch JsDoc
nmap <leader>jj :JsDoc<cr>

" resize splits faster
map <leader>> 10<C-w>>
map <leader>< 10<C-w><
map <leader>= 5<C-w>+ 
map <leader>- 5<C-w>-

" Sets how many lines of history VIM has to remember
set history=700

" This maps Leader + e to exit terminal mode.
if has('nvim')
  tnoremap <C-n> <C-\><C-n>
endif

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Switch syntax highlighting on, when the terminal has colors
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" USER INTERFACE
""""""""""""""""""""""""""""""""""""""""
syntax on
set t_Co=256
set background=dark
colorscheme tender

" Open new split panes to right and bottom
set splitbelow
set splitright

" Fold indentation, but not at start
set foldmethod=indent
set nofoldenable

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif
" enable mouse in entire big screens
if has("mouse_sgr")
  set ttymouse=sgr
else
  if !has('nvim')
    set ttymouse=xterm2
  endif
end

set hlsearch       " Highlight search results
set incsearch      " Find as you type
set ignorecase
set smartcase
set lazyredraw     " Don't redraw while executing macros (good performance config)
set magic          " For regular expressions turn magic on
set showmatch      " Show matching brackets when text indicator is over them
set cursorline     " Highlight current line
set scrolloff=3    " don't let the cursor touch the edge of the viewport

" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab      " Use spaces instead of tabs
set smarttab       " Be smart when using tabs ;)
set shiftwidth=2   " indent with 2 spoaces
set tabstop=2      " 1 tab == 2 spaces
set softtabstop=2

" intelligent line numbers
set number
set relativenumber

let delimitMate_expand_cr=1 " indent new line when cursor is between brackets, parentheses, ...

" Indent guides color and character
let g:indentLine_color_term = 238
let g:indentLine_char = '⦙'

" don't ask before loading .vimrc file
let g:localvimrc_ask=0

" Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in git
set nobackup
set nowb
set noswapfile
" copy/paste to/from system clipboard
set clipboard=unnamedplus
" reload file when changed externally
:au CursorHold * checktime

" Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

" Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" tab navigation
map <m-l> :tabnext<CR>
map <m-h> :tabprev<CR>

" move up/down single lines or selected ones
nnoremap J :m .+1<CR>==
nnoremap K :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Remap VIM 0 to first non-blank character
map 0 ^

" This prevents * from jumping to the next match.
nnoremap * :keepjumps normal! mi*`i<CR>

" Preserve selection after indentation
vmap > >gv
vmap < <gv
" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv


" fix lprevius and lnext behaviour
" https://github.com/scrooloose/syntastic/issues/32#issuecomment-40273385
function! <SID>LocationPrevious()
  try
    lprev
  catch /^Vim\%((\a\+)\)\=:E553/
    llast
  endtry
endfunction

function! <SID>LocationNext()
  try
    lnext
  catch /^Vim\%((\a\+)\)\=:E553/
    lfirst
  endtry
endfunction

nnoremap <silent> <Plug>LocationPrevious    :<C-u>exe 'call <SID>LocationPrevious()'<CR>
nnoremap <silent> <Plug>LocationNext        :<C-u>exe 'call <SID>LocationNext()'<CR>
nmap <silent> <leader>lp    <Plug>LocationPrevious
nmap <silent> <leader>ln    <Plug>LocationNext


" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end


" Turn persistent undo on
if has("persistent_undo")
    set undodir=~/.vim/.undodir/
    set undofile
endif

" show cursorline just in current buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

au InsertEnter * hi CursorLineNr guifg=#bec468 ctermfg=149
au InsertLeave * hi CursorLineNr guifg=#66afce ctermfg=74
