-- [[ Setting options ]]
-- See `:help vim.o`
--
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.history = 700

-- Search options
vim.o.ignorecase = true -- Case insensitive searching
vim.o.smartcase = true -- UNLESS /C or capital in search
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Find as you type
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-- vim.opt.lazyredraw       = true -- Don't redraw while executing macros
vim.opt.magic = true -- For regular expressions turn magic on

-- Decrease update time
vim.o.updatetime = 250
-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- -- Wildmenu
-- vim.o.wildmenu = true
-- vim.o.wildignore = vim.o.wildignore .. "*/tmp/*,*.so,*.swp,*.zip"

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

vim.opt.backspace = "2"
vim.opt.showcmd = true

vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.laststatus = 3
vim.opt.autowrite = true
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
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99

vim.opt.showmatch = true -- Highlight matching brackets under cursor
vim.opt.cursorline = true -- Highlight current line
vim.opt.scrolloff = 10 -- don't let the cursor touch the edge of the viewport

vim.opt.clipboard = "unnamedplus"

-- Files, backups and undo
-- ------------------------------------------------
-- Turn backup off, since most stuff is in git
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.wb = false
vim.opt.swapfile = false
vim.opt.updatetime = 300
-- always show signcolumns
vim.opt.signcolumn = "yes"

Nmap("<leader><CR>", function()
	require("notify").dismiss({ silent = true, pending = false })
	vim.cmd.noh()
end, "Clear search higlights and notifications")

vim.cmd([[
	xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

	function! ExecuteMacroOverVisualRange()
		echo "@".getcmdline()
		execute ":'<,'>normal @".nr2char(getchar())
	endfunction
]])

-- Automatically jump to the last place you’ve visited in a file
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Abbreviations
vim.cmd([[
	:iabbrev fucntion function
	:iabbrev fucntino function
	:iabbrev functino function
	:iabbrev cosnt const
	:iabbrev ocnst const
	:iabbrev exprot export
]])

-- Launch notification when starting and ending macro recording
vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		-- Little delay because reg_recording() can be empty right after entering
		vim.defer_fn(function()
			local reg = vim.fn.reg_recording()
			if reg ~= "" then
				vim.notify("📹 Recording macro: '" .. reg .. "'", vim.log.levels.INFO)
			end
		end, 50) -- 50ms should be a good delay to ensure the recording is captured
	end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		vim.notify("✅ Macro recording ended", vim.log.levels.INFO)
	end,
})
