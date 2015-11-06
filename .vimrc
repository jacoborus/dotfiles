" VUNDLE
"""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required by Vundle
filetype off                  " required by Vundle
runtime macros/matchit.vim

call plug#begin('~/.vim/plugged')
" Plug 'gmarik/Vundle.vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'

Plug 'Valloric/YouCompleteMe'

Plug 'ntpeters/vim-better-whitespace'
Plug 'moll/vim-node'
Plug 'myusuf3/numbers.vim'
Plug 'digitaltoad/vim-jade'
Plug 'embear/vim-localvimrc'
Plug 'arecarn/fold-cycle.vim'

Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'
" Required by vim-session
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'dyng/ctrlsf.vim'
Plug 'Yggdroot/indentLine'
Plug 'regedarek/ZoomWin'
Plug 'mattn/emmet-vim'
Plug 'pricco/vim-monokai'
Plug 'suan/vim-instant-markdown'
Plug 'terryma/vim-multiple-cursors'

Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json'

Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'mbbill/undotree'
Plug 'othree/yajs.vim'
Plug 'ap/vim-css-color'
Plug 'benekastah/neomake'

call plug#end()
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" vim-jsdoc
"""""""""""""""""""""""""""""""
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_enable_es6 = 1

" emmet
""""""""""""""""""""""""""""""
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-y>'

" ctrlp
""""""""""""""""""""""""""""""""
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|\v(node_modules|bower_components)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" ViM Lightline
""""""""""""""""""""""""""""""""
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': { 'ñ': 'NORMAL' },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))'
      \ },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'fileformat': 'MyFileFormat',
      \   'filename': 'MyFilename',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
       \  &ft == 'unite' ? unite#get_status_string() :
       \  &ft == 'vimshell' ? vimshell#get_status_string() :
       \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  if winwidth(0) > 90
    if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
      let _ = fugitive#head()
      return strlen(_) ? ' '._ : ''
    endif
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 60 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return ''
  " return winwidth(0) > 100 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 120 ? lightline#mode() : ' '
endfunction

highlight ExtraWhitespace ctermbg=52

" Raimondi/delimitMate settings
"""""""""""""""""""""""""""""""
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" Tmuxline settings
" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'b'    : '#W',
"       \'win'  : '#I #W',
"       \'cwin' : '#I #W',
"       \'x'    : '%R',
"       \'y'    : '#(whoami)',
"       \'z'    : '#H'}


" CtrlSF
"""""""""""""""""""""""""""""""""""""""
nmap     <leader>f <Plug>CtrlSFPrompt

" Syntax JSON
"""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
let g:vim_json_syntax_conceal = 0


"""""""""""""""""""""""""""""""""""""""""
" GENERAL
"""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
" Fast saving
nmap <leader>w :w<cr>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" fast open/close quickfix
nmap <leader>lo :lopen<cr>
nmap <leader>lc :lcl<cr>

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
" session management
"""""""""""""""""""
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"

nnoremap <leader>so :OpenSession<space>
nnoremap <leader>ss :SaveSession<space>
nnoremap <leader>sd :DeleteSession<space>
nnoremap <leader>sc :CloseSession<space>

" USER INTERFACE
""""""""""""""""""""""""""""""""""""""""
syntax on
set t_Co=256
set background=dark
colorscheme monokai

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
hi CursorLine   cterm=NONE ctermbg=236 ctermfg=NONE guibg=darkred guifg=white
set scrolloff=3    " don't let the cursor touch the edge of the viewport

" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab      " Use spaces instead of tabs
set smarttab       " Be smart when using tabs ;)
set shiftwidth=2   " indent with 2 spoaces
set tabstop=2      " 1 tab == 2 spaces
set softtabstop=2

let delimitMate_expand_cr=1 " indent new line when cursor is between brackets, parentheses, ...

" intelligent line numbers
set number
set relativenumber

" Indent guides color and character
let g:indentLine_color_term = 239
let g:indentLine_char = '⦙'

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
map L :tabnext<CR>
map H :tabprev<CR>

" move up/down single lines or selected ones
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv

" Remap VIM 0 to first non-blank character
map 0 ^

" Turn persistent undo on
if has("persistent_undo")
    set undodir=~/.vim/.undodir/
    set undofile
endif

" NEOMAKE
let g:neomake_javascript_enabled_makers = ['eslint']
" run neomake when opening and writing javascript files
autocmd! BufWritePost *.js Neomake
au BufReadPost *.js Neomake

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

