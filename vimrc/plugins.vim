" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

" Vim-windowswap
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>m :call WindowSwap#EasyWindowSwap()<CR>

" FZF
let $FZF_DEFAULT_COMMAND = 'ag -g "" --path-to-ignore .gitignore --hidden --ignore .git'
let $FZF_DEFAULT_OPTS=""
nnoremap <leader>p :Files<CR>
nnoremap <leader>a :Ag<space>
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" vim-localvimrc
"""""""""""""""""""""""""""
" don't ask before loading .vimrc file
let g:localvimrc_ask=0

" vim-jsdoc
"""""""""""""""""""""""""""""""
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_enable_es6 = 1

" vim-vue / fix syntax highlighting
autocmd FileType vue syntax sync fromstart
" disable checking for prepocessors to improve performance on vue files
let g:vue_disable_pre_processors=1

" emmet
""""""""""""""""""""""""""""""
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,vue EmmetInstall
" expand html with tab
autocmd FileType html,css,php,vue map <tab> <plug>(emmet-expand-abbr)i

" Vim Table Mode
let g:table_mode_corner='|'

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


" fast launch JsDoc
nmap <leader>jj :JsDoc<cr>


" Syntax JSON
"""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
let g:vim_json_syntax_conceal = 0


" NERDTree
""""""""""
nnoremap <leader>n :NERDTreeToggle<cr>


" GitGutter
"""""""""""
let g:gitgutter_sign_modified_removed = '÷'
nnoremap <leader>gh :GitGutterLineHighlightsToggle<cr>
nmap ]g <Plug>GitGutterNextHunk
nmap [g <Plug>GitGutterPrevHunk
" update the signs when saving a file
autocmd BufWritePost * GitGutter
" update after focusing Vim
let g:gitgutter_terminal_reports_focus=0
" ⋍

" CtrlSF
"""""""""""""""""""""""""""""""""""""""
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }
nnoremap <leader>ff :CtrlSF<space>
nnoremap <leader>fo :CtrlSFOpen<cr>
nnoremap <leader>fw <Plug>CtrlSFVwordExec
nnoremap <leader>ft :CtrlSFToggle<cr>


" HLinkTrace
"""""""""""""""""""""""""""
nnoremap <leader>hh :HLT<CR>

" ntpeters/vim-better-whitespace
""""""""""""""""""""""""""""""""
hi ExtraWhitespace ctermbg=238 guibg=#666666

" indentline
"""""""""""""
" Indent guides color and character┆│¦⦙
let g:indentLine_char = '¦'
" Vim
let g:indentLine_color_term = 238
"GVim
let g:indentLine_color_gui = '#3A3A3A'

" haya14busa/incsearch.vim
""""""""""""""""""""""""""
" let g:incsearch#auto_nohlsearch = 1
" map n  <Plug>(incsearch-nohl-n)
" map N  <Plug>(incsearch-nohl-N)
" map *  <Plug>(incsearch-nohl-*)
" map #  <Plug>(incsearch-nohl-#)
" map g* <Plug>(incsearch-nohl-g*)
" map g# <Plug>(incsearch-nohl-g#)
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
"


