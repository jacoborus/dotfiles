" enable true color in neovim
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" VUNDLE
"""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required by Vundle
filetype off                  " required by Vundle
runtime macros/matchit.vim

call plug#begin('~/.config/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

Plug 'carlitux/deoplete-ternjs'

function! BuildTern(info)
  if a:info.status == 'installed' || a:info.force
    !npm install
  endif
endfunction
Plug 'ternjs/tern_for_vim', { 'do': function('BuildTern') }

Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'moll/vim-node'
Plug 'myusuf3/numbers.vim'
Plug 'digitaltoad/vim-jade'
Plug 'embear/vim-localvimrc'
Plug 'arecarn/fold-cycle.vim'

Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree'

Plug 'xolox/vim-misc' " Required by vim-session
Plug 'xolox/vim-session'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'dyng/ctrlsf.vim'
Plug 'Yggdroot/indentLine'
Plug 'regedarek/ZoomWin'
Plug 'mattn/emmet-vim'
Plug 'suan/vim-instant-markdown'
Plug 'terryma/vim-multiple-cursors'

Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json'

Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc'
Plug 'mbbill/undotree'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'ap/vim-css-color'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wavded/vim-stylus'
Plug 'terryma/vim-expand-region'
Plug 'gerw/vim-HiLinkTrace'

Plug '~/dev/tender'
" Plug '~/dev/tierno'


call plug#end()
filetype plugin indent on

let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1
" let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
 
" Let <Tab> also do completion
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()

" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" vim-jsdoc
"""""""""""""""""""""""""""""""
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_enable_es6 = 1

" emmet
""""""""""""""""""""""""""""""
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" expand html with tab
autocmd FileType html,css imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

" ctrlp
""""""""""""""""""""""""""""""""
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$|\v(node_modules|bower_components)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" Instant Markdown
""""""""""""""""""
let g:instant_markdown_autostart = 0

" ViM Lightline
""""""""""""""""""""""""""""""""
set laststatus=2 " Always show status line
let g:lightline = {
      \ 'colorscheme': 'tender',
      \ 'mode_map': { 'n': 'NORMAL' },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ],
      \   'right': [ [ 'percent' ], ['fugitive'] ]
      \ },
      \ 'inactive': {
      \   'right': [ [ 'percent' ] ]
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
  return winwidth(0) > 90 ? lightline#mode() : ' '
endfunction


" Raimondi/delimitMate settings
"""""""""""""""""""""""""""""""
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" Tmuxline settings
" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'b'    : '#W',
"       \'win'  : '#I #W',
"       \'cwin' : '#I #W',
"       \'x'    : '%R',
"       \'z'    : '#H'}


" Syntax JSON
"""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
let g:vim_json_syntax_conceal = 0


"""""""""""""""""""""""""""""""""""""""""
" GENERAL
"""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" change buffer
nmap <leader>bn :bn<cr>
nmap <leader>bp :bp<cr>

" Fast saving
nmap <leader>w :w<cr>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" fast open/close quickfix
nmap <leader>lo :lopen<cr>
nmap <leader>lc :lcl<cr>

" fast open/close quickfix
nmap <leader>jj :JsDoc<cr>

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

" NERDTree
""""""""""
nnoremap <leader>n :NERDTreeToggle<cr>

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

let delimitMate_expand_cr=1 " indent new line when cursor is between brackets, parentheses, ...

" intelligent line numbers
set number
set relativenumber

" Indent guides color and character
let g:indentLine_color_term = 238
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

" Preserve selection after indentation
vmap > >gv
vmap < <gv
" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" Turn persistent undo on
if has("persistent_undo")
    set undodir=~/.vim/.undodir/
    set undofile
endif

" NEOMAKE
" run neomake when opening and writing javascript files
autocmd! BufWritePost *.js Neomake
au BufReadPost *.js Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_error_sign = {'text': '⦆'}
" another pretty symbols ɛ ∊ ƭ ℯ Ҽ ⨉ × ʗ ᚛ ᚜ ⌁ ▸ ⦆ ⬮ ⬯ ⬥

" gitgutter
let g:gitgutter_sign_modified_removed = '÷'

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

" CtrlSF
"""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ff :CtrlSF<space>
nnoremap <leader>fo :CtrlSFOpen<cr>

"""" theme tweaks
" show cursorline just in current buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

au InsertEnter * hi CursorLineNr ctermfg=148
au InsertLeave * hi CursorLineNr ctermfg=81

hi GitGutterAdd ctermfg=148
hi GitGutterDelete ctermfg=197
hi GitGutterChange ctermfg=81
hi GitGutterChangeDelete ctermfg=141

" HLinkTrace
"""""""""""""""""""""""""""
nnoremap <leader>hh :HLT<CR>

" hi ExtraWhitespace ctermbg=52
