local gh = function(repo, branch)
	local spec = { src = "https://github.com/" .. repo }
	if branch then
		spec.branch = branch
	end
	return spec
end

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		if ev.data.kind == "install" or ev.data.kind == "update" then
			if name == "telescope-fzf-native.nvim" then
				vim.system({ "make" }, { cwd = ev.data.path }):wait()
			end
			if name == "LuaSnip" then
				if vim.fn.executable("make") == 1 then
					vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path }):wait()
				end
			end
		end
	end,
})

vim.g.windowswap_map_keys = 0

vim.pack.add({
	-- { src = "~/dev/tender", name = "tender" },
	gh("jacoborus/tender", "lua" ),
	gh("nvim-lualine/lualine.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("tpope/vim-sleuth"),
	gh("onsails/lspkind.nvim"),
	gh("christoomey/vim-tmux-navigator"),
	gh("AndrewRadev/tagalong.vim"),
	gh("tpope/vim-surround"),
	gh("jiangmiao/auto-pairs"),
	gh("numToStr/Comment.nvim"),
	gh("gerw/vim-HiLinkTrace"),
	gh("dyng/ctrlsf.vim"),
	gh("lukas-reineke/indent-blankline.nvim"),
	-- gh("ziglang/zig.vim"),
	gh("lewis6991/gitsigns.nvim"),
	gh("petertriho/nvim-scrollbar"),
	gh("karb94/neoscroll.nvim"),
	gh("wesQ3/vim-windowswap"),
	gh("folke/zen-mode.nvim"),
	gh("tpope/vim-fugitive"),
	gh("tpope/vim-rhubarb"),
	gh("sindrets/diffview.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("folke/which-key.nvim"),
	gh("folke/lazydev.nvim"),
})

require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

require("plugin_config.statusline")

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

Nmap("<leader>hh", ":HLT<CR>", "Show highlight_group")
Nmap("<leader>hi", ":Inspect<CR>", "Inspect treesitter highlight_group")

vim.g.ctrlsf_auto_focus = { at = "start" }
Nmap("<leader>ff", ":CtrlSF<space>", "CtrlSF")
Nmap("<leader>fo", ":CtrlSFOpen<cr>", "CtrlSF [O]pen")
Nmap("<leader>ft", ":CtrlSFToggle<cr>", "CtrlSF [T]oggle")

require("Comment").setup()

Nmap("<leader>m", ":call WindowSwap#EasyWindowSwap()<CR>", "Swap window", { silent = true })

require("zen-mode").setup({})

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "÷" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>hS", gs.stage_buffer)
		map("n", "<leader>hu", gs.undo_stage_hunk)
		map("n", "<leader>hR", gs.reset_buffer)
		map("n", "<leader>hp", gs.preview_hunk)
		map("n", "<leader>hb", function()
			gs.blame_line({ full = true })
		end)
		map("n", "<leader>tb", gs.toggle_current_line_blame)
		map("n", "<leader>hd", gs.diffthis)
		map("n", "<leader>hD", function()
			gs.diffthis("~")
		end)
		map("n", "<leader>td", gs.toggle_deleted)

		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})
require("scrollbar.handlers.gitsigns").setup()

require("scrollbar").setup()

require("neoscroll").setup({ duration_multiplier = 0.5 })
vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>", { silent = true })
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>", { silent = true })
vim.keymap.set("i", "<ScrollWheelUp>", "<C-y>", { silent = true })
vim.keymap.set("i", "<ScrollWheelDown>", "<C-e>", { silent = true })
vim.keymap.set("v", "<ScrollWheelUp>", "<C-y>", { silent = true })
vim.keymap.set("v", "<ScrollWheelDown>", "<C-e>", { silent = true })

Nmap("[g", ":Gitsigns prev_hunk<CR>", "Navigate to previus git hunk")
Nmap("]g", ":Gitsigns next_hunk<CR>", "Navigate to next git hunk")

vim.o.background = "dark"
vim.cmd("colorscheme tender-blue")
vim.cmd([[highlight Headline guibg=#464632]])

vim.o.timeout = true
vim.o.timeoutlen = 300

require("which-key").setup({})

vim.pack.add({
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-treesitter/nvim-treesitter-textobjects"),
	gh("nvim-treesitter/nvim-treesitter-context"),
})

require("plugin_config.treesitter")

vim.pack.add({
	gh("nvim-telescope/telescope.nvim"),
	gh("nvim-telescope/telescope-fzf-native.nvim"),
	gh("nvim-telescope/telescope-ui-select.nvim"),
})

require("plugin_config.telescope")

vim.pack.add({
	gh("nvim-tree/nvim-tree.lua"),
})

require("plugin_config.nvim-tree")

vim.pack.add({
	gh("hrsh7th/nvim-cmp"),
	gh("L3MON4D3/LuaSnip"),
	gh("saadparwaiz1/cmp_luasnip"),
	gh("hrsh7th/cmp-nvim-lsp"),
	gh("hrsh7th/cmp-path"),
	gh("hrsh7th/cmp-buffer"),
})

vim.pack.add({
	gh("mason-org/mason.nvim"),
})

require("mason").setup()

vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end
		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
		map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
		map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>k", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")
		map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	end,
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			completion = { callSnippet = "Replace" },
		},
	},
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
				vim.notify(
					"Could not find `vtsls` lsp client, `vue_ls` would not work without it.",
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

-- vim.lsp.config("tsgo", {
-- 	settings = {
-- 		typescript = {
-- 			inlayHints = {
-- 				parameterNames = { enabled = "literals", suppressWhenArgumentMatchesName = true },
-- 				parameterTypes = { enabled = true },
-- 				variableTypes = { enabled = true },
-- 				propertyDeclarationTypes = { enabled = true },
-- 				functionLikeReturnTypes = { enabled = true },
-- 				enumMemberValues = { enabled = true },
-- 			},
-- 		},
-- 	},
-- })
-- vim.lsp.enable("tsgo")

for _, name in ipairs(servers) do
	vim.lsp.enable(name)
end

require("plugin_config.completions")

vim.pack.add({
	gh("folke/todo-comments.nvim"),
	gh("youyoumu/pretty-ts-errors.nvim"),
	gh("danymat/neogen"),
	gh("folke/noice.nvim"),
	gh("MunifTanjim/nui.nvim"),
	gh("rcarriga/nvim-notify"),
})

require("todo-comments").setup({ signs = false })
require("notify").setup({ merge_duplicates = true, render = "compact" })

require("pretty-ts-errors").setup({
	executable = "pretty-ts-errors-markdown",
	float_opts = {
		border = "rounded",
		max_width = 80,
		max_height = 20,
		wrap = false,
	},
	auto_open = false,
	lazy_window = false,
})

vim.keymap.set("n", "<leader>te", function()
	require("pretty-ts-errors").show_formatted_error()
end, { desc = "Show TS error" })

vim.keymap.set("n", "<leader>tE", function()
	require("pretty-ts-errors").open_all_errors()
end, { desc = "Show all TS errors" })

vim.keymap.set("n", "<leader>tt", function()
	require("pretty-ts-errors").toggle_auto_open()
end, { desc = "Toggle TS error auto-display" })

require("neogen").setup({})
Nmap("<leader>gd", ":Neogen<cr>", "[G]enerate [D]ocs")

require("noice").setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	routes = {
		{
			filter = {
				event = "msg_show",
				any = {
					{ find = "%d+L, %d+B" },
					{ find = "; after #%d+" },
					{ find = "; before #%d+" },
				},
			},
			view = "mini",
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = true,
	},
})

vim.api.nvim_create_autocmd("CmdUndefined", {
	pattern = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	once = true,
	callback = function()
		vim.pack.add({
			gh("kristijanhusak/vim-dadbod-ui"),
			gh("tpope/vim-dadbod"),
			gh("kristijanhusak/vim-dadbod-completion"),
		})
		vim.g.db_ui_use_nerd_fonts = 1
		vim.cmd([[
			autocmd FileType sql,mysql,plsql,sqlite lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
		]])
	end,
})

vim.keymap.set("n", "<leader>ol", function()
	vim.pack.add({ gh("hedyhli/outline.nvim") })
	vim.cmd.Outline()
end, { desc = "Toggle outline" })

vim.api.nvim_create_autocmd("BufWritePre", {
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
				tsx = { "eslint", "prettier" },
				typescript = { "eslint", "prettier" },
				vue = { "eslint", "prettier" },
				yaml = { "yamlfix" },
				sql = { "sql_formatter" },
			},
		})
	end,
})
