local highlight = { "TenderBlue5" }
local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "TenderBlue5", { fg = "#293b44" })
end)
require("ibl").setup({
	indent = { char = "┊", highlight = highlight },
	whitespace = { remove_blankline_trail = false },
	scope = { enabled = false },
})
