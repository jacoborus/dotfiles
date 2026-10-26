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
			elseif name == "nvim-treesitter" then
				-- Los parsers deben actualizarse junto al plugin.
				require("nvim-treesitter").update()
			end
		end
	end,
})

-- Dependencies ------------------------------------------------------------
vim.pack.add({
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("folke/lazydev.nvim"),
})

-- UI: theme, statusline, decorations --------------------------------------
vim.pack.add({
	gh("jtprogru/pack-ui.nvim"),
	-- { src = "~/dev/tender", name = "tender" },
	gh("jacoborus/tender", "lua"),
	gh("nvim-lualine/lualine.nvim"),
	gh("lukas-reineke/indent-blankline.nvim"),
	{ src = "https://github.com/petertriho/nvim-scrollbar", version = "v1" },
	gh("karb94/neoscroll.nvim"),
	gh("folke/zen-mode.nvim"),
	gh("folke/which-key.nvim"),
})

-- Editing & search --------------------------------------------------------
vim.pack.add({
	gh("tpope/vim-sleuth"),
	gh("christoomey/vim-tmux-navigator"),
	gh("AndrewRadev/tagalong.vim"),
	gh("tpope/vim-surround"),
	gh("jiangmiao/auto-pairs"),
	gh("dyng/ctrlsf.vim"),
	-- gh("ziglang/zig.vim"),
})

-- Git ---------------------------------------------------------------------
vim.pack.add({
	gh("lewis6991/gitsigns.nvim"),
	gh("tpope/vim-fugitive"),
	gh("tpope/vim-rhubarb"),
	gh("sindrets/diffview.nvim"),
})

-- Treesitter --------------------------------------------------------------
vim.pack.add({
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-context"),
})

-- Pickers -----------------------------------------------------------------
vim.pack.add({
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
})

-- File tree ---------------------------------------------------------------
vim.pack.add({
	gh("nvim-tree/nvim-tree.lua"),
})

-- LSP ---------------------------------------------------------------------
vim.pack.add({
	gh("neovim/nvim-lspconfig"),
	gh("mason-org/mason.nvim"),
	gh("stevearc/conform.nvim"),
})

-- Messaging & docs --------------------------------------------------------
vim.pack.add({
	gh("folke/todo-comments.nvim"),
	gh("danymat/neogen"),
	gh("folke/noice.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("rcarriga/nvim-notify"),
})

-- Setup -------------------------------------------------------------------

require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

require("plugin_config.statusline")

require("plugin_config.ibl")

require("plugin_config.hilink_trace")

vim.keymap.set("n", "<leader>hi", ":Inspect<CR>", { desc = "Inspect highlight group at cursor" })
vim.keymap.set("n", "<leader>hh", ":HLT<CR>", { desc = "HiLinkTrace at cursor" })

vim.g.ctrlsf_auto_focus = { at = "start" }
vim.keymap.set("n", "<leader>ff", ":CtrlSF<space>", { desc = "CtrlSF" })
vim.keymap.set("n", "<leader>fo", ":CtrlSFOpen<cr>", { desc = "CtrlSF [O]pen" })
vim.keymap.set("n", "<leader>ft", ":CtrlSFToggle<cr>", { desc = "CtrlSF [T]oggle" })

-- Intercambia buffers entre dos splits conservando los tamaños. Dos pasos:
-- primera pulsación marca, segunda intercambia (<C-w>x no cruza layouts mixtos).
vim.keymap.set("n", "<leader>m", require("plugin_config.window_swap").easy_swap, {
	desc = "Swap buffers sin cambiar tamaños",
	silent = true,
})

require("zen-mode").setup({})

require("plugin_config.gitsigns")

require("scrollbar").setup()

require("neoscroll").setup({ duration_multiplier = 0.5 })

vim.cmd("colorscheme tender-blue")
vim.cmd([[highlight Headline guibg=#464632]])

require("which-key").setup({})

require("plugin_config.treesitter")

require("plugin_config.telescope")

require("plugin_config.nvim-tree")

require("plugin_config.lsp")

require("todo-comments").setup({ signs = false })
require("notify").setup({ merge_duplicates = true, render = "compact" })

require("neogen").setup({})
vim.keymap.set("n", "<leader>gd", ":Neogen<cr>", { desc = "[G]enerate [D]ocs" })

require("plugin_config.noice")

-- Lazy-loaded plugins -----------------------------------------------------

vim.api.nvim_create_autocmd("CmdUndefined", {
	pattern = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	once = true,
	callback = function(ev)
		vim.pack.add({
			gh("kristijanhusak/vim-dadbod-ui"),
			gh("tpope/vim-dadbod"),
		})
		vim.g.db_ui_use_nerd_fonts = 1
		-- CmdUndefined aborta el comando original: relanzarlo ya con el plugin cargado.
		vim.cmd(ev.match)
	end,
})

local outline_setup = false
vim.keymap.set("n", "<leader>ol", function()
	if not outline_setup then
		vim.pack.add({ gh("hedyhli/outline.nvim") })
		require("outline").setup()
		outline_setup = true
	end
	vim.cmd("Outline")
end, { desc = "Toggle outline" })

require("plugin_config.conform")
