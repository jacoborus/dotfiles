-- Render de Markdown dentro del buffer: tablas, headings, código, checkboxes...
-- Se carga de forma diferida desde plugins.lua al abrir el primer .md.
require("render-markdown").setup({
	pipe_table = {
		-- Bordes redondeados y celdas alineadas al ancho de cada columna.
		preset = "round",
		cell = "padded",
		style = "full",
	},
})

-- Atajos locales a los buffers de markdown.
local function set_keymaps(buf)
	vim.keymap.set("n", "<leader>mm", "<cmd>RenderMarkdown buf_toggle<cr>", {
		buffer = buf,
		desc = "Markdown: alternar render",
	})
	vim.keymap.set("n", "<leader>mp", "<cmd>RenderMarkdown preview<cr>", {
		buffer = buf,
		desc = "Markdown: preview lateral",
	})
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	group = vim.api.nvim_create_augroup("render-markdown-keymaps", { clear = true }),
	callback = function(ev)
		set_keymaps(ev.buf)
	end,
})

-- El FileType que dispara la carga ya se ha emitido, así que aplicamos también
-- al buffer actual.
if vim.bo.filetype == "markdown" then
	set_keymaps(vim.api.nvim_get_current_buf())
end
