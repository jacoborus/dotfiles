set nocompatible              " be iMproved, required
filetype off                  " required
set nocompatible
filetype plugin on
runtime macros/matchit.vim

" show quotes in json files
let g:vim_json_syntax_conceal = 0

" Open new split panes to right and bottom
set splitbelow
set splitright

" Fold indentation, but not at start
set foldmethod=indent
set nofoldenable

" Set to auto read when a file is changed from the outside
set autoread

" Enable mouse scrolling
set mouse=a

" Indent guides color and character
let g:indentLine_color_term = 239
let g:indentLine_char = '⦙'

set number
set relativenumber
let g:localvimrc_ask=0
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'itchyny/lightline.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-surround'

Plugin 'ntpeters/vim-better-whitespace'
Plugin 'moll/vim-node'
Plugin 'myusuf3/numbers.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'embear/vim-localvimrc'
Plugin 'arecarn/fold-cycle.vim'
" Plugin 'garbas/vim-snipmate'
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

" SYNTASTIC
set statusline+=%#WARNINGMSG#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
colorscheme monokai
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" status line
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': { 'ñ': 'NORMAL' },
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
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
  return winwidth(0) > 100 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 120 ? lightline#mode() : ''
endfunction

highlight ExtraWhitespace ctermbg=52
