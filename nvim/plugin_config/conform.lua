local gh = function(repo)
	return { src = "https://github.com/" .. repo }
end

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.pack.add({ gh("stevearc/conform.nvim") })
		require("conform").setup({
			notify_on_error = false,
			format_on_save = { timeout_ms = 1000, lsp_fallback = true },
			formatters_by_ft = {
				bash = { "shfmt" },
				go = { "goimports", "gofmt" },
				html = { "eslint", "prettier" },
				javascript = { "eslint", "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				jsx = { "eslint", "prettier" },
				json = { "prettier" },
				tsx = { "eslint", "prettier" },
				typescript = { "eslint", "prettier" },
				vue = { "eslint", "prettier" },
				yaml = { "yamlfix" },
				sql = { "sql_formatter" },
			},
		})
	end,
})
