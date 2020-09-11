" coc.nvim
"""""""""""""""
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [a <Plug>(coc-diagnostic-prev)
nmap <silent> ]a <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

map <silent> <leader>cr :CocRestart<cr>
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>


" Vim-windowswap
""""""""""""""""
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>m :call WindowSwap#EasyWindowSwap()<CR>


" FZF
"""""
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
""""""""""""""""
" don't ask before loading .vimrc file
let g:localvimrc_ask=0


" vim-jsdoc
"""""""""""""""""""""""""""""""
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_enable_es6 = 1
" fast launch JsDoc
nmap <leader>jj :JsDoc<cr>


" vim-vue / fix syntax highlighting
autocmd FileType vue syntax sync fromstart
" disable checking for prepocessors to improve performance on vue files
let g:vue_disable_pre_processors=1


" emmet
"""""""
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,vue EmmetInstall
" expand html with tab
autocmd FileType html,css,php,vue map <tab> <plug>(emmet-expand-abbr)i


" Vim Table Mode
""""""""""""""""
let g:table_mode_corner='|'


" Syntax JSON
"""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead .eslintrc setlocal filetype=json
autocmd BufNewFile,BufRead .eslintrc setlocal conceallevel=0
let g:vim_json_syntax_conceal = 0


" NERDTree
""""""""""
nnoremap <leader>n :NERDTreeToggle<cr>


" GitGutter
"""""""""""
let g:gitgutter_sign_modified_removed = '÷'
nnoremap <leader>gh :GitGutterLineHighlightsToggle<cr>
nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)
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
let g:indentLine_faster = 0
" let g:indentLine_concealcursor = ''

" autocmd FileType vimwiki let b:indentLine_enabled=0
" autocmd FileType vimwiki let b:indentLine_setConceal=0

augroup FILETYPES
  " autocmd FileType vimwiki let b:indentLine_enabled = 0
  autocmd FileType markdown let b:indentLine_enabled = 0
  autocmd FileType markdown let b:vimwiki_conceallevel = 0
  " autocmd FileType markdown setlocal conceallevel=0
augroup END

" VimWiki
" let g:vimwiki_conceallevel = 0
let g:vimwiki_list = [{
  \ 'path': '~/vimwiki',
  \ 'syntax': 'markdown',
  \ 'ext': '.md',
  \ 'auto_diary_index': 1
  \ }]

nmap <Leader>wc <Plug>VimwikiSplitLink
nmap <Leader>wv <Plug>VimwikiVSplitLink
