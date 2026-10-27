require("nvim-treesitter").setup({})

-- Parsers que queremos disponibles. `install()` es asíncrono y no hace nada si
-- ya están instalados.
require("nvim-treesitter").install({
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
})

-- Neovim 0.12 solo arranca treesitter por defecto en algunas filetypes
-- (lua, markdown, help...). Lo activamos en cualquier buffer que tenga parser.
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(ev.buf)
		end
	end,
})

require("treesitter-context").setup({
	max_lines = 20,
	min_window_height = 0,
})
