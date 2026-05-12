-- [[ Configure fzf-lua ]]
local fzf = require("fzf-lua")

fzf.setup({
	keymap = {
		fzf = {
			["ctrl-j"] = "down",
			["ctrl-k"] = "up",
		},
	},
})

fzf.register_ui_select()

vim.keymap.set("n", "<leader>fk", fzf.keymaps, { desc = "[F]ind [K]eymap definitions" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "[F]ind existing [B]uffers" })
vim.keymap.set("n", "<leader>p", function() fzf.files({ hidden = true }) end, { desc = "Find [F]iles" })
vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "[F]ind [h]elp" })
vim.keymap.set("n", "<leader>fw", fzf.grep_cword, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fd", fzf.diagnostics_workspace, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>/", fzf.blines, { desc = "[/] Fuzzily search in current buffer" })
