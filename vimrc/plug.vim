" vim-plug
"""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

Plug '~/dev/tender'
" Plug 'jacoborus/tender'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

function! BuildTern(info)
  if a:info.status == 'installed' || a:info.force
    !npm install
  endif
endfunction

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/context_filetype.vim'
Plug 'ternjs/tern_for_vim', { 'do': function('BuildTern') }
Plug 'carlitux/deoplete-ternjs'

" Plug 'tpope/vim-dispatch'
" Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'myusuf3/numbers.vim'
Plug 'arecarn/fold-cycle.vim'
Plug 'tpope/vim-commentary'
Plug 'Shougo/unite.vim'
Plug 'Shougo/unite-outline'
Plug 'scrooloose/nerdtree'
Plug 'dyng/ctrlsf.vim'
Plug 'Yggdroot/indentLine'
Plug 'terryma/vim-expand-region'
Plug 'haya14busa/incsearch.vim'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'edkolev/tmuxline.vim'
Plug 'KabbAmine/vCoolor.vim'
Plug 'xolox/vim-misc' " Required by vim-session
Plug 'xolox/vim-session'

Plug 'suan/vim-instant-markdown'

Plug 'mattn/emmet-vim'
Plug 'ap/vim-css-color'
Plug 'digitaltoad/vim-pug'
Plug 'wavded/vim-stylus'
Plug 'elzr/vim-json'

" JS
Plug 'moll/vim-node'
Plug 'heavenshell/vim-jsdoc'
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'

Plug 'embear/vim-localvimrc'
Plug 'editorconfig/editorconfig-vim'
Plug 'benekastah/neomake'
Plug 'christoomey/vim-tmux-navigator'
Plug 'gerw/vim-HiLinkTrace'


call plug#end()
