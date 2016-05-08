" vim-plug
"""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

Plug '~/dev/tender'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'

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

" Plug 'tpope/vim-dispatch'
" Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'myusuf3/numbers.vim'
Plug 'arecarn/fold-cycle.vim'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'dyng/ctrlsf.vim'
Plug 'Yggdroot/indentLine'
Plug 'terryma/vim-expand-region'
Plug 'haya14busa/incsearch.vim'

" Plug 'edkolev/tmuxline.vim'

Plug 'xolox/vim-misc' " Required by vim-session
Plug 'xolox/vim-session'

Plug 'suan/vim-instant-markdown'
Plug 'terryma/vim-multiple-cursors'

Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'digitaltoad/vim-jade'
Plug 'wavded/vim-stylus'
Plug 'elzr/vim-json'
" JS
Plug 'moll/vim-node'
Plug 'heavenshell/vim-jsdoc'
" Plug '~/dev/vim-jsdoc'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'

Plug 'embear/vim-localvimrc'
Plug 'editorconfig/editorconfig-vim'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gerw/vim-HiLinkTrace'


call plug#end()
