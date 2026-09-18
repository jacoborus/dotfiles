require("mason").setup()

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>k", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	end,
})

local servers = {
	"astro",
	"autotools_ls",
	"bashls",
	"cssls",
	"dockerls",
	"emmet_ls",
	"eslint",
	"gopls",
	"golangci_lint_ls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"sqlls",
	"vimls",
	"yamlls",
}

-- Resolve the @vue/language-server location: prefer the global npm prefix,
-- fall back to Mason. Both layouts expose node_modules/@vue/language-server.
local function find_vue_language_server()
	local npm_root = vim.system({ "npm", "root", "-g" }):wait()
	local prefix = npm_root.code == 0 and vim.trim(npm_root.stdout) or vim.fn.expand("~/.npm-packages/lib/node_modules")
	local candidates = {
		prefix .. "/@vue/language-server",
		vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
	}
	for _, path in ipairs(candidates) do
		if vim.uv.fs_stat(path) then
			return path
		end
	end
	return candidates[1]
end

local vue_language_server_path = find_vue_language_server()
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}
local vtsls_config = {
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = { vue_plugin },
			},
		},
	},
	-- lspconfig's vtsls filetypes don't include Vue SFC
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	on_attach = function(client)
		-- vue_ls handles semantic tokens for .vue buffers (vue-language-server v3.0.2+)
		client.server_capabilities.semanticTokensProvider.full = vim.bo.filetype ~= "vue"
	end,
}

vim.lsp.config("vtsls", vtsls_config)
vim.lsp.enable({ "vtsls", "vue_ls" })

-- Preserve old semantic token highlighting for Vue components
vim.api.nvim_set_hl(0, "@lsp.type.component", { link = "@type" })

for _, name in ipairs(servers) do
	vim.lsp.enable(name)
end

vim.o.autocomplete = true
vim.o.pumborder = "rounded"
vim.lsp.completion.enable()

-- Tab: next completion item when popup is visible, jump snippet placeholder, else insert tab
vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-n>"
	elseif vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
		return ""
	else
		return "<Tab>"
	end
end, { expr = true })

-- S-Tab: prev completion item when popup is visible, else passthrough
vim.keymap.set("i", "<S-Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<C-p>"
	else
		return "<S-Tab>"
	end
end, { expr = true })
