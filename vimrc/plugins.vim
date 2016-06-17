" deoplete
"""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 2
let g:deoplete#enable_refresh_always = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
" call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
" autocmd CompleteDone * pclose!
" set omnifunc=syntaxcomplete#Complete
" set completeopt=longest,menuone,preview,noinsert

" neosnippet
""""""""""""""
function! s:go_tab()
  if pumvisible()
    return "\<C-n>"
  else
    if neosnippet#expandable_or_jumpable()
      return "\<Plug>(neosnippet_expand_or_jump)"
    else
      return "\<Tab>"
    endif
  endif
endfunction
" Let <Tab> also do completion
imap <silent><expr> <Tab> <SID>go_tab()

" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

function! s:neosnippet_complete()
  if pumvisible()
    if neosnippet#expandable_or_jumpable()
      return "\<Plug>(neosnippet_expand_or_jump)"
    endif
  endif
  return "\<Plug>delimitMateCR"
endfunction

imap <expr><CR> <SID>neosnippet_complete()

" vim-localvimrc
"""""""""""""""""""""""""""
" don't ask before loading .vimrc file
let g:localvimrc_ask=0

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
let delimitMate_expand_cr=1 " indent new line when cursor is between brackets, parentheses, ...
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

" indentline
"""""""""""""
" Indent guides color and character
let g:indentLine_char = '⦙'
" Vim
let g:indentLine_color_term = 238
"GVim
let g:indentLine_color_gui = '#444444'

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
