local util = require("conform.util")

local format_opts = { timeout_ms = 1000, lsp_format = "fallback" }

require("conform").setup({
	notify_on_error = true,
	format_on_save = format_opts,
	formatters = {
		oxlint = {
			cwd = util.root_file({ ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts", "package.json" }),
		},
	},
	formatters_by_ft = {
		bash = { "shfmt" },
		go = { "goimports", "gofmt" },
		html = { "oxfmt" },
		javascript = { "oxlint", "oxfmt" },
		javascriptreact = { "oxlint", "oxfmt" },
		lua = { "stylua" },
		python = { "isort", "black" },
		json = { "oxfmt" },
		typescript = { "oxlint", "oxfmt" },
		typescriptreact = { "oxlint", "oxfmt" },
		vue = { "oxlint", "oxfmt" },
		yaml = { "yamlfix" },
		sql = { "sql_formatter" },
	},
})

local function format_buffer()
	local ok = require("conform").format(vim.tbl_extend("force", format_opts, { async = true }))
	if not ok then
		vim.notify("Format: no formatter for " .. vim.bo.filetype, vim.log.levels.WARN)
	end
end

vim.api.nvim_create_user_command("Format", format_buffer, {
	force = true,
	desc = "Format current buffer",
})

vim.keymap.set("n", "<leader>bf", format_buffer, {
	desc = "Format buffer",
})
