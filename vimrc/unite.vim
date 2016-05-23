" unite.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use ag (the silver searcher)
" https://github.com/ggreer/the_silver_searcher
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
\ '-i --vimgrep --hidden --ignore ' .
\ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <buffer> <ESC> <Plug>(unite_exit)
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <c-j> <Plug>(unite_insert_leave)
  imap <buffer> <c-k> <Plug>(unite_insert_leave)
  nmap <buffer> <c-j> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <c-k> <Plug>(unite_loop_cursor_up)
  nmap <buffer> <tab> <Plug>(unite_loop_cursor_down)
  nmap <buffer> <s-tab> <Plug>(unite_loop_cursor_up)
  imap <buffer> <Tab> <Plug>(unite_insert_leave)
  nmap <buffer> <C-r> <Plug>(unite_redraw)
  imap <buffer> <C-r> <Plug>(unite_redraw)
endfunction

" Start in insert mode
let g:unite_enable_start_insert = 1
" Open in bottom right
let g:unite_split_rule = "botright"
" replace controlP with unite
nnoremap <C-p> :<C-u>Unite -start-insert file_rec/async:!<CR>
" nnoremap <leader>r :<C-u>Unite -start-insert file_rec/async:!<CR>

" grep in current directory
nnoremap <leader>fc :Unite grep:.<CR>
" grep in cwd
execute "nnoremap <leader>fa :Unite grep:" . unite#util#path2project_directory(getcwd()) . "<CR>"
" resume grep
nnoremap <leader>fr :UniteResume<CR>
