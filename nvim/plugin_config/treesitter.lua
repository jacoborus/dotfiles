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

require("treesitter-context").setup({
	max_lines = 20,
	min_window_height = 0,
})