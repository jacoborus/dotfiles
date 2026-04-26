require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"bash",
		"c",
		"cpp",
		"css",
		"csv",
		"diff",
		"dockerfile",
		"git_rebase",
		"gitattributes",
		"gitignore",
		"go",
		"graphql",
		"html",
		"http",
		"javascript",
		"jsdoc",
		"json",
		"jsonc",
		"lua",
		"markdown",
		"python",
		"regex",
		"scss",
		"sql",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vue",
		"xml",
		"yaml",
		"zig",
	},
	callback = function()
		pcall(vim.treesitter.language.install, vim.bo.filetype)
	end,
})

require("nvim-treesitter-textobjects").setup({
	select = {
		enable = true,
		lookahead = true,
		keymaps = {
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
		},
	},
	move = {
		enable = true,
		set_jumps = true,
		goto_next_start = {
			["]m"] = "@function.outer",
			["]]"] = "@class.outer",
		},
		goto_next_end = {
			["]M"] = "@function.outer",
			["]["] = "@class.outer",
		},
		goto_previous_start = {
			["[m"] = "@function.outer",
			["[["] = "@class.outer",
		},
		goto_previous_end = {
			["[M"] = "@function.outer",
			["[]"] = "@class.outer",
		},
	},
})

require("treesitter-context").setup({
	max_lines = 20,
	min_window_height = 0,
})