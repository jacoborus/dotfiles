local gh = function(repo, branch)
	local spec = { src = "https://github.com/" .. repo }
	if branch then
		spec.branch = branch
	end
	return spec
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		if ev.data.kind == "install" or ev.data.kind == "update" then
			if name == "telescope-fzf-native.nvim" then
				vim.system({ "make" }, { cwd = ev.data.path }):wait()
			end
		end
	end,
})

vim.g.windowswap_map_keys = 0

vim.pack.add({
	-- { src = "~/dev/tender", name = "tender" },
	gh("jtprogru/pack-ui.nvim"),
	gh("jacoborus/tender", "lua"),
	gh("nvim-lualine/lualine.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("tpope/vim-sleuth"),
	gh("christoomey/vim-tmux-navigator"),
	gh("AndrewRadev/tagalong.vim"),
	gh("tpope/vim-surround"),
	gh("jiangmiao/auto-pairs"),
	gh("numToStr/Comment.nvim"),
	gh("gerw/vim-HiLinkTrace"),
	gh("dyng/ctrlsf.vim"),
	gh("lukas-reineke/indent-blankline.nvim"),
	-- gh("ziglang/zig.vim"),
	gh("lewis6991/gitsigns.nvim"),
	gh("petertriho/nvim-scrollbar"),
	gh("karb94/neoscroll.nvim"),
	gh("wesQ3/vim-windowswap"),
	gh("folke/zen-mode.nvim"),
	gh("tpope/vim-fugitive"),
	gh("tpope/vim-rhubarb"),
	gh("sindrets/diffview.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("folke/which-key.nvim"),
	gh("folke/lazydev.nvim"),
})

require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

require("plugin_config.statusline")

require("plugin_config.ibl")

vim.keymap.set("n", "<leader>hh", ":HLT<CR>", { desc = "Show highlight_group" })
vim.keymap.set("n", "<leader>hi", ":Inspect<CR>", { desc = "Inspect treesitter highlight_group" })

vim.g.ctrlsf_auto_focus = { at = "start" }
vim.keymap.set("n", "<leader>ff", ":CtrlSF<space>", { desc = "CtrlSF" })
vim.keymap.set("n", "<leader>fo", ":CtrlSFOpen<cr>", { desc = "CtrlSF [O]pen" })
vim.keymap.set("n", "<leader>ft", ":CtrlSFToggle<cr>", { desc = "CtrlSF [T]oggle" })

require("Comment").setup()

vim.keymap.set("n", "<leader>m", ":call WindowSwap#EasyWindowSwap()<CR>", { desc = "Swap window", silent = true })

require("zen-mode").setup({})

require("plugin_config.gitsigns")

require("scrollbar").setup()

require("neoscroll").setup({ duration_multiplier = 0.5 })

vim.o.background = "dark"
vim.cmd("colorscheme tender-blue")
vim.cmd([[highlight Headline guibg=#464632]])

vim.o.timeout = true
vim.o.timeoutlen = 300

require("which-key").setup({})

vim.pack.add({
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-context"),
})

require("plugin_config.treesitter")

vim.pack.add({
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
})

require("plugin_config.telescope")

vim.pack.add({
	gh("nvim-tree/nvim-tree.lua"),
})

require("plugin_config.nvim-tree")

vim.pack.add({
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
})

require("plugin_config.lsp")

vim.pack.add({
	gh("folke/todo-comments.nvim"),
	gh("danymat/neogen"),
	gh("folke/noice.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("rcarriga/nvim-notify"),
})

require("todo-comments").setup({ signs = false })
require("notify").setup({ merge_duplicates = true, render = "compact" })

require("neogen").setup({})
vim.keymap.set("n", "<leader>gd", ":Neogen<cr>", { desc = "[G]enerate [D]ocs" })

require("plugin_config.noice")

vim.api.nvim_create_autocmd("CmdUndefined", {
	pattern = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	once = true,
	callback = function()
		vim.pack.add({
			gh("kristijanhusak/vim-dadbod-ui"),
			gh("tpope/vim-dadbod"),
		})
		vim.g.db_ui_use_nerd_fonts = 1
	end,
})

vim.keymap.set("n", "<leader>ol", function()
	vim.pack.add({ gh("hedyhli/outline.nvim") })
	require("outline").setup()
	vim.cmd.Outline()
end, { desc = "Toggle outline" })

require("plugin_config.conform")
