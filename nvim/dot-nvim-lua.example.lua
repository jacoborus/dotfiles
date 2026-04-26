-- ============================================================================
-- EXAMPLE: `.nvim.lua` for project-local LSP switching (tsgo)
-- ============================================================================
--
-- How to use:
-- 1. Copy this file into your project root and rename it to `.nvim.lua`
-- 2. Neovim will automatically source it when you open the project
--    (you'll get a security prompt the first time — choose 'y' to trust it)
--
-- What this does:
-- It detaches `vtsls` and attaches `tsgo` for TypeScript/JavaScript files
-- in this specific project only.
--
-- Prerequisites:
-- - `exrc` and `secure` must be enabled in your global options (already done)
-- - `tsgo` must be installed and available in your $PATH
-- - The `tsgo` LSP config must be registered globally (already done in plugins.lua)
--
-- ============================================================================

-- Buffer-local autocmd to swap vtsls -> tsgo for TypeScript buffers
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("project-use-tsgo", { clear = true }),
	pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	callback = function(args)
		-- Detach vtsls if it already attached to this buffer
		for _, client in ipairs(vim.lsp.get_clients({ bufnr = args.buf, name = "vtsls" })) do
			vim.lsp.buf_detach_client(args.buf, client.id)
		end

		-- Start tsgo for this buffer
		vim.lsp.start(vim.lsp.config("tsgo"), { bufnr = args.buf })
	end,
})
