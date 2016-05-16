" deoplete
"""""""""""""""""""""""""""""""""""""""""""
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
autocmd FileType html,css,php EmmetInstall
" expand html with tab
autocmd FileType html,css,php map <tab> <plug>(emmet-expand-abbr)i

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


" Raimondi/delimitMate settings
"""""""""""""""""""""""""""""""
let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END


" Tmuxline settings
"""""""""""""""""""
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


" NEOMAKE
" run neomake when opening and writing javascript files
autocmd! BufWritePost *.js Neomake
au BufReadPost *.js Neomake
let g:neomake_javascript_enabled_makers = ['standard']
" let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_error_sign = {'text': 'ƭ'}
" another pretty symbols for errors ɛ ∊ ƭ ℯ Ҽ ⨉ × ʗ ᚛ ᚜ ⌁ ▸ ⦆


" gitgutter
let g:gitgutter_sign_modified_removed = '÷'
" ⋍

" CtrlSF
"""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ff :CtrlSF<space>
nnoremap <leader>fo :CtrlSFOpen<cr>


" HLinkTrace
"""""""""""""""""""""""""""
nnoremap <leader>hh :HLT<CR>

" ntpeters/vim-better-whitespace
""""""""""""""""""""""""""""""""
hi ExtraWhitespace ctermbg=238 guibg=#444444

" haya14busa/incsearch.vim
""""""""""""""""""""""""""
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
