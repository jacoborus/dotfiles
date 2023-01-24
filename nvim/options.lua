-- [[ Setting options ]]
-- See `:help vim.o`

vim.opt.termguicolors = true

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
-- vim.o.undofile = true
vim.o.history = 700

-- Search options
vim.o.ignorecase   = true -- Case insensitive searching
vim.o.smartcase    = true -- UNLESS /C or capital in search
vim.opt.hlsearch   = true -- Highlight search results
vim.opt.incsearch  = true -- Find as you type
vim.opt.lazyredraw = true -- Don't redraw while executing macros
vim.opt.magic      = true -- For regular expressions turn magic on

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Wildmenu
vim.o.wildmenu = true
vim.o.wildignore = vim.o.wildignore .. '*/tmp/*,*.so,*.swp,*.zip'


-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smarttab = true -- Be smart when using tabs

-- Open new split panes to right and bottom
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Fold indentation, but not at start
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99


vim.opt.showmatch = true -- Highlight matching brackets under cursor
vim.opt.cursorline = true -- Highlight current line
vim.opt.scrolloff = 3 -- don't let the cursor touch the edge of the viewport

vim.opt.clipboard = 'unnamedplus'

-- Files, backups and undo
-- ------------------------------------------------
-- Turn backup off, since most stuff is in git
-- vim.opt.nobackup = true
-- vim.opt.nowritebackup = true
-- vim.opt.nowb = true
-- vim.opt.noswapfile = true
vim.opt.updatetime = 300
-- don't give |ins-completion-menu| messages.
-- vim.opt.shortmess = vim.opt.shortmess .. c
-- always show signcolumns
vim.opt.signcolumn = 'yes'

-- autosave
-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.cmd [[
  xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

  function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
  endfunction
]]
