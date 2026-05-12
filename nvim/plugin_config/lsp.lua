vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
		map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
		map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
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

local vue_language_server_path = vim.fn.expand("$MASON/packages")
		.. "/vue-language-server"
		.. "/node_modules/@vue/language-server"
local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}
local vtsls_config = {
	cmd = { "vtsls", "--stdio" },
	root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = { vue_plugin },
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}

local vue_ls_config = {
	on_init = function(client)
		client.handlers["tsserver/request"] = function(_, result, context)
			local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
			if #clients == 0 then
				clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "tsgo" })
			end
			if #clients == 0 then
				vim.notify(
					"Could not find `vtsls` or `tsgo` lsp client, `vue_ls` would not work without one of them.",
					vim.log.levels.ERROR
				)
				return
			end
			local ts_client = clients[1]

			local param = unpack(result)
			local id, command, payload = unpack(param)
			ts_client:exec_cmd({
				title = "vue_request_forward",
				command = "typescript.tsserverRequest",
				arguments = {
					command,
					payload,
				},
			}, { bufnr = context.bufnr }, function(_, r)
				local response_data = { { id, r.body } }
				client:notify("tsserver/response", response_data)
			end)
		end
	end,
}
vim.lsp.config("vtsls", vtsls_config)
vim.lsp.config("vue_ls", vue_ls_config)
vim.lsp.enable({ "vtsls", "vue_ls" })
vim.lsp.config("denols", {
	root_markers = { "deno.json", "deno.jsonc" },
})
vim.lsp.enable({ "denols" })

-- Register tsgo config globally so it can be activated per-project via .nvim.lua
-- To use tsgo in a specific project, create a `.nvim.lua` in that project's root
-- (see `dot-nvim-lua.example.lua` in this directory for the template)
vim.lsp.config("tsgo", {
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = { enabled = "literals", suppressWhenArgumentMatchesName = true },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
	},
})
-- vim.lsp.enable("tsgo") -- Do NOT enable globally; enable per-project in `.nvim.lua`

for _, name in ipairs(servers) do
	vim.lsp.enable(name)
end
