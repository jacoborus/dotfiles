local util = require("conform.util")

require("conform").setup({
	notify_on_error = true,
	format_on_save = { timeout_ms = 1000, lsp_fallback = true },
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
