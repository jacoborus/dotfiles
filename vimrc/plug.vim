" vim-plug
"""""""""""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')

Plug '~/dev/tender.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'

" Markdown
Plug 'nelstrom/vim-markdown-folding'
Plug 'dhruvasagar/vim-table-mode'
Plug 'junegunn/goyo.vim'

" Status
Plug 'itchyny/lightline.vim'

Plug 'Shougo/context_filetype.vim'
Plug 'mustache/vim-mustache-handlebars'

" General utils
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Yggdroot/indentLine'
Plug 'tyru/caw.vim' " comment plugin
Plug 'scrooloose/nerdtree'
Plug 'kana/vim-repeat'
Plug 'dyng/ctrlsf.vim'
Plug 'wesQ3/vim-windowswap'
Plug 'embear/vim-localvimrc'
Plug 'editorconfig/editorconfig-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'gerw/vim-HiLinkTrace'

" Languages and syntaxes
Plug 'posva/vim-vue'
Plug 'othree/html5.vim'
Plug 'mattn/emmet-vim'
" Plug 'ap/vim-css-color'
Plug 'digitaltoad/vim-pug'
Plug 'iloginow/vim-stylus'
Plug 'elzr/vim-json'

" JS
Plug 'moll/vim-node'
Plug 'heavenshell/vim-jsdoc'
Plug 'pangloss/vim-javascript'
" Plug 'othree/yajs.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kevinoid/vim-jsonc'
Plug 'vimwiki/vimwiki'

call plug#end()
" :CocInstall coc-json coc-tsserver coc-html coc-css coc-vetur coc-yaml coc-emmet coc-lists coc-git coc-eslint
