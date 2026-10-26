require("conform").setup({
	notify_on_error = true,
	format_on_save = { timeout_ms = 1000, lsp_fallback = true },
	formatters_by_ft = {
		bash = { "shfmt" },
		go = { "goimports", "gofmt" },
		html = { "eslint_d", "prettier" },
		javascript = { "eslint_d", "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
		jsx = { "eslint_d", "prettier" },
		json = { "prettier" },
		tsx = { "eslint_d", "prettier" },
		typescript = { "eslint_d", "prettier" },
		vue = { "eslint_d", "prettier" },
		yaml = { "yamlfix" },
		sql = { "sql_formatter" },
	},
})
