"""""""""""""""""""""""""""""""""""""
" VUNDLE
"""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required by Vundle
filetype off                  " required by Vundle
runtime macros/matchit.vim

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'

if !has('nvim')
  Plugin 'Valloric/YouCompleteMe'
endif
Plugin 'tpope/vim-surround'
" Plugin 'Shougo/neocomplete.vim'

Plugin 'ntpeters/vim-better-whitespace'
Plugin 'moll/vim-node'
Plugin 'myusuf3/numbers.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'embear/vim-localvimrc'
Plugin 'arecarn/fold-cycle.vim'

Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'dyng/ctrlsf.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'regedarek/ZoomWin'
Plugin 'mattn/emmet-vim'
Plugin 'pricco/vim-monokai'
Plugin 'suan/vim-instant-markdown'
Plugin 'terryma/vim-multiple-cursors'

Plugin 'edkolev/tmuxline.vim'
Plugin 'elzr/vim-json'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'pangloss/vim-javascript'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""
" SYNTASTIC
""""""""""""""""""""""""""""""""""
set statusline+=%#WARNINGMSG#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" set eslint as javascript checker
let g:syntastic_javascript_checkers = ['eslint']

"""""""""""""""""""""""""""""""
" vim-jsdoc
"""""""""""""""""""""""""""""""
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_enable_es6 = 1
""""""""""""""""""""""""""""""
" emmet
""""""""""""""""""""""""""""""
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-y>'
""""""""""""""""""""""""""""""""
" ctrlp
""""""""""""""""""""""""""""""""
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
""""""""""""""""""""""""""""""""
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
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
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
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
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

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost * call s:syntastic()
augroup END

highlight ExtraWhitespace ctermbg=52

"""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""
" CtrlSF
"""""""""""""""""""""""""""""""""""""""
nmap     <C-f> <Plug>CtrlSFPrompt

"""""""""""""""""""""""""""""""""""""""""
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

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

""""""""""""""""""""""""""""""""""""""""
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
set lazyredraw     " Don't redraw while executing macros (good performance config)
set magic          " For regular expressions turn magic on
set showmatch      " Show matching brackets when text indicator is over them
set cursorline     " Highlight current line
set scrolloff=3    " don't let the cursor touch the edge of the viewport

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in git 
set nobackup
set nowb
set noswapfile
set clipboard=unnamedplus   " copy/paste to/from system clipboard
:au CursorHold * checktime  " reload file when changed externally

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Smart way to move between windows
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
  set undodir=~/.vim_runtime/temp_dirs/undodir
  set undofile
catch
endtry


