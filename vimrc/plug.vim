" vim-plug
"""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

" Plug '~/dev/tender'
Plug 'jacoborus/tender'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

" Markdown
Plug 'nelstrom/vim-markdown-folding'
Plug 'dhruvasagar/vim-table-mode'

Plug 'itchyny/lightline.vim'

" Plug 'mustache/vim-mustache-handlebars'

" General utils
Plug 'tpope/vim-surround'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'myusuf3/numbers.vim'
Plug 'Yggdroot/indentLine'
Plug 'tyru/caw.vim' " comment plugin
Plug 'scrooloose/nerdtree'
Plug 'kana/vim-repeat'
Plug 'dyng/ctrlsf.vim'
Plug 'wesQ3/vim-windowswap'

" Plug 'terryma/vim-expand-region'
" Plug 'vim-airline/vim-airline'
" Plug 'edkolev/tmuxline.vim'

" Languages and syntaxes
Plug 'posva/vim-vue'
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'
Plug 'digitaltoad/vim-pug'
Plug 'iloginow/vim-stylus'
Plug 'elzr/vim-json'

" JS
Plug 'moll/vim-node'
Plug 'heavenshell/vim-jsdoc'
Plug 'pangloss/vim-javascript'
" Plug 'othree/yajs.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'embear/vim-localvimrc'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'gerw/vim-HiLinkTrace'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()
