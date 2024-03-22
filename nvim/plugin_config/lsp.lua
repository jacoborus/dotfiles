-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("<leader>k", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")
	-- if client.server_capabilities.documentFormattingProvider then
	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
	--   vim.lsp.buf.format()
	-- end, { desc = 'Format current buffer with LSP' })
end

vim.api.nvim_create_user_command("Format", function(_)
	vim.lsp.buf.format({
		-- use prettier instead of volar for formatting vue files
		filter = function(client)
			return client.name ~= "volar"
		end,
	})
end, { desc = "Format current buffer with LSP" })

-- LSP servers in the following table  will automatically be installed.
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
-- only servers from this list are available for autoinstall
-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
local servers = {
	autotools_ls = {}, -- Make
	bashls = {},
	cssls = {},
	dockerls = {},
	emmet_ls = {},
	eslint = {},
	gopls = {},
	golangci_lint_ls = {},
	html = {},
	jsonls = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	marksman = {},
	sqlls = {},
	-- tsserver = {},
	vimls = {},
	volar = {}, -- Vue
	yamlls = {},
	-- why do these not work?
	-- shfmt = {},
	-- stylua = {},
	-- yamlfix = {},
}

-- Setup neovim lua configuration
require("neodev").setup()

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

servers["zls"] = {}

local lspconfig = require("lspconfig")

lspconfig.zls.setup({})

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = on_attach,
			capabilities = Capabilities,
			settings = servers[server_name],
		})
	end,
})

-- volar
lspconfig.volar.setup({
	-- on_attach = on_attach,
	-- autostart = false,
	capabilities = Capabilities,
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
})

-- denols
lspconfig.denols.setup({
	on_attach = on_attach,
	capabilities = Capabilities,
	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
})

-- -- tsserver
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   capabilities = Capabilities,
--   autostart = false,
--   root_dir = lspconfig.util.root_pattern("package.json"),
-- }

vim.g.zig_fmt_autosave = 0

-- Turn on lsp status information
require("fidget").setup()

-- Enable LSP symbols tree
require("symbols-outline").setup()
