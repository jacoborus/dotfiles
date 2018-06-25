"""""""""""""""""""""""""""""""""""""""""
" GENERAL
"""""""""""""""""""""""""""""""""""""""""
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

set guicursor=

" simplenote
" so ~/.simplenoterc
" let g:SimplenoteVertical=1
" let g:gista#client#default_username='jacoborus'

" Enable filetype plugins
filetype plugin on
filetype indent on

" enable true color in neovim
set termguicolors

set conceallevel=0

" be iMproved
set nocompatible

" <space> as leader key
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Fast saving
nmap <leader>w :w<cr>

" change buffer
nmap <leader>bn :bn<cr>
nmap <leader>bp :bp<cr>

" repeat last command line command
nnoremap <leader>r @:<CR>

" fast copy to the end of the line
nmap Y y$

set wildmenu
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" resize splits faster
map <leader>> <C-w>10>
map <leader>< <C-w>10<
map <leader>= <C-w>5+
map <leader>- <C-w>5-

" live sustitution
if exists('&inccommand')
  set inccommand=split
endif

" Sets how many lines of history VIM has to remember
set history=700

" This maps control+n to exit terminal mode.
if has('nvim')
  tnoremap <C-n> <C-\><C-n>
endif

" Set to auto read when a file is changed from the outside
set autoread

" Check if files changed externally
augroup checktime
  au!
  if !has("gui_running")
    "silent! necessary otherwise throws errors when using command
    "line window.
    autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime
  endif
augroup END

" au BufRead,BufNewFile *.vue set ft=html.vue
" au BufRead,BufNewFile *.vue set ft=html
" au BufRead,BufNewFile *.vue set ft=vue.html

" USER INTERFACE
""""""""""""""""""""""""""""""""""""""""

" set color scheme
colorscheme tender

" Status bar theme
""""""""""""""""
" let g:airline_theme = 'tender'
" let g:airline_powerline_fonts = 1

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
set lazyredraw     " Don't redraw while executing macros
set magic          " For regular expressions turn magic on
set showmatch      " Highlight matching brackets under cursor
set cursorline     " Highlight current line
set scrolloff=3    " don't let the cursor touch the edge of the viewport

" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab      " Use spaces instead of tabs
set smarttab       " Be smart when using tabs
set shiftwidth=2   " indent with 2 spaces
set tabstop=2      " 1 tab == 2 spaces
set softtabstop=2
set pumheight=15   " limit completion menu height

" intelligent line numbers
set number
set relativenumber


" Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in git
set nobackup
set nowb
set noswapfile
" copy/paste to/from system clipboard
set clipboard=unnamedplus
map <c-p> "0p
map <m-p> "0P
" reload file when changed externally
:au CursorHold * checktime

" Moving around, tabs, windows and buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" move to the exact position on marks
noremap ' `
noremap ` '

" Treat long lines as break lines
map j gj
map k gk

" Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" tab navigation with alt+l / alt+h
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

" fast open/close quickfix
nmap <leader>lo :lopen<cr>
nmap <leader>lc :lcl<cr>


" omnifuncs
augroup omnifuncs
  autocmd!
  " autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  " autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  " autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType css,stylus setlocal omnifunc=
  autocmd FileType html,markdown setlocal omnifunc=
  autocmd FileType python setlocal omnifunc=
augroup end


" Turn persistent undo on
if has("persistent_undo")
    set undodir=~/.config/nvim/undodir/
    set undofile
endif

" show cursorline just in current buffer
" augroup CursorLine
"   au!
"   au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
"   au WinLeave * setlocal nocursorline
" augroup END

au InsertEnter * hi CursorLineNr guifg=#bec468 ctermfg=149
au InsertLeave * hi CursorLineNr guifg=#66afce ctermfg=74

" Execute macro over visual range (line by line)
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction


" Abbreviations
"""""""""""""""""""""""
:iabbrev fucntion function
:iabbrev fucntino function
:iabbrev functino function
:iabbrev cosnt const
