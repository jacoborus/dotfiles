" unite.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:unite_force_overwrite_statusline = 0
" Use ag (the silver searcher)
" https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:unite_source_rec_async_command =
  \ ['ag', '--follow', '--nocolor', '--nogroup',
  \  '--hidden', '-g', '']
  let g:unite_source_rec_min_cache_files = 1200
  let g:unite_source_grep_command = 'ag'
  " let g:unite_source_grep_default_opts = '--nocolor --nogroup --hidden'
  let g:unite_source_grep_default_opts =
  \ '-i --vimgrep --hidden --ignore ' .
  \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
endif

" Set to some better time formats
let g:unite_source_buffer_time_format = "%Y-%m-%d  %H:%M:%S  "
let g:unite_update_time	= 500
let g:unite_prompt = '»'
" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  nmap <buffer> <ESC> <Plug>(unite_exit)
  imap <buffer> <C-r> <Plug>(unite_redraw)
  imap <silent><buffer><expr> <C-s> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction

" Start in insert mode
let g:unite_enable_start_insert = 1
" Open in bottom right
let g:unite_split_rule = "botright"
" replace controlP with unite
nnoremap <leader>p :<C-u>Unite -start-insert file_rec/neovim<CR>

" grep in current directory
nnoremap <leader>fa :Unite line:buffers<CR>
nnoremap <leader>o :Unite outline<CR>
" grep in cwd
execute "nnoremap <leader>fg :Unite grep:" . unite#util#path2project_directory(getcwd()) . "<CR>"
" resume grep
nnoremap <leader>fr :UniteResume<CR>
