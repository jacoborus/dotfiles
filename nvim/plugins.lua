-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- these lines need to load before Lazy, otherwise ignored
vim.g.wikimatic_path = "~/wiki"
vim.g.windowswap_map_keys = 0 -- prevent default bindings

require("mapping")

require("lazy").setup({
	{
		"folke/neoconf.nvim",
		cmd = "Neoconf",
		dependencies = { "nvim-lspconfig", "williamboman/mason.nvim" },
		config = function()
			require("neoconf").setup({
				-- override any of the default settings here
			})
		end,
	},

	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically,
	"onsails/lspkind.nvim",
	"christoomey/vim-tmux-navigator",
	"AndrewRadev/tagalong.vim", -- Change an HTML opening tag and take the closing one along as well
	"tpope/vim-surround",
	"jiangmiao/auto-pairs",
	"nvim-lualine/lualine.nvim", -- Fancier statusline,

	{
		"gerw/vim-HiLinkTrace",
		config = function()
			vim.g.hilinktrace_enable_on_startup = 1
			Nmap("<leader>hh", ":HLT<CR>", "Show highlight_group")
			Nmap("<leader>hi", ":Inspect<CR>", "Inspect treesitter highlight_group")
		end,
	},

	{
		"dyng/ctrlsf.vim",
		config = function()
			vim.g.ctrlsf_auto_focus = { at = "start" }
			Nmap("<leader>ff", ":CtrlSF<space>", "CtrlSF")
			Nmap("<leader>fo", ":CtrlSFOpen<cr>", "CtrlSF [O]pen")
			Nmap("<leader>ft", ":CtrlSFToggle<cr>", "CtrlSF [T]oggle")
		end,
	},

	{ -- Add indentation guides even on blank lines,
		"lukas-reineke/indent-blankline.nvim",
		version = "3.5.6",
		main = "ibl",
		config = function()
			local highlight = {
				"TenderBlue5",
			}

			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "TenderBlue5", { fg = "#293b44" })
			end)

			require("ibl").setup({
				indent = {
					char = "┊",
					highlight = highlight,
				},
				whitespace = {
					remove_blankline_trail = false,
				},
				scope = { enabled = false },
			})
		end,
	},

	{ "numToStr/Comment.nvim", opts = {} },

	{
		"jacoborus/tender.vim",
		-- dir = "~/dev/tender",
		config = function()
			vim.o.background = "dark"
			vim.cmd("colorscheme tender")
			vim.cmd([[highlight Headline guibg=#464632]])
		end,
	},

	-- { -- headlines for markdown files
	-- 	"lukas-reineke/headlines.nvim",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	config = function()
	-- 		vim.cmd([[highlight Headline guibg=#464632]])
	-- 		require("headlines").setup({
	-- 			markdown = {
	-- 				headline_highlights = { "Headline" },
	-- 				bullets = { "✿", "❱", "⫼", "⫵", "⩨", "⩩" },
	-- 			},
	-- 		})
	-- 	end, -- or `opts = {}`
	-- },

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			-- Setup neovim lua configuration

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("<leader>k", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			local servers = {
				astro = {},
				autotools_ls = {}, -- Make
				bashls = {},
				-- cssls = {},
				dockerls = {},
				emmet_ls = {},
				denols = {
					root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
				},
				-- eslint = {},
				gopls = {},
				golangci_lint_ls = {},
				html = {},
				jsonls = {},
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
				marksman = {},
				sqlls = {},
				ts_ls = {
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = vim.fn.expand("$MASON/node_modules/@vue/language-server"),
								languages = { "vue" },
							},
						},
					},
					filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
					root_dir = require("lspconfig").util.root_pattern("tsconfig.json"),
					single_file_support = false,
				},
				vimls = {},
				volar = {}, -- Vue
				yamlls = {},
			}

			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
				"shfmt",
				"yamlfix",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = ensure_installed,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for ts_ls)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- Inline annotation and documentation generator
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
			Nmap("<leader>gd", ":Neogen<cr>", "[G]enerate [D]ocs")
		end,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
	},

	{ -- SQL UI
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql", "sqlite" }, lazy = true },
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Your DBUI configuration
			vim.g.db_ui_use_nerd_fonts = 1
			vim.cmd([[
				autocmd FileType sql,mysql,plsql,sqlite lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
			]])
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				go = { "goimports", "gofmt" },
				lua = { "stylua" },
				markdown = { "deno_fmt" },
				python = { "isort", "black" },
				bash = { "shfmt" },
				vue = { "eslint_d", "prettier" },
				yaml = { "yamlfix" },
				-- json = { { "prettierd", "prettier" } },
				javascript = { "eslint_d", "prettier" },
				typescript = { "eslint_d", "prettier" },
				html = { "eslint_d", "prettier" },
				tsx = { "eslint_d", "prettier" },
			},
		},
	},

	{
		"dmmulroy/ts-error-translator.nvim",
		config = function()
			require("ts-error-translator").setup()
		end,
	},

	{
		"OlegGulevskyy/better-ts-errors.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			keymaps = {
				toggle = "<leader>dd", -- default '<leader>dd'
				go_to_definition = "<leader>dx", -- default '<leader>dx'
			},
		},
	},

	{ -- notifications, messages, cmdline and the popupmenu
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
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
		},

		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup({
						merge_duplicates = true,
						render = "compact",
					})
				end,
			},
		},
	},

	{ -- configures LuaLs for Neovim
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					-- {
					--   'rafamadriz/friendly-snippets',
					--   config = function()
					--     require('luasnip.loaders.from_vscode').lazy_load()
					--   end,
					-- },
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},

		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,

		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noselect" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- If you prefer more traditional completion keymaps,
					-- you can uncomment the following lines
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{ name = "copilot", group_index = 2 },
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol", -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						symbol_map = {
							Copilot = "",
						},
					}),
				},
			})
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"html",
					"lua",
					"markdown",
					"vim",
					"vimdoc",
					"tsx",
				},
				-- Autoinstall languages that are not installed
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	{ -- the file tree
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			{
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
				enabled = vim.g.have_nerd_font,
			},
		},
	},

	{
		"wesQ3/vim-windowswap",
		config = function()
			Nmap("<leader>m", ":call WindowSwap#EasyWindowSwap()<CR>", "Swap window", { silent = true })
		end,
	},

	{
		"jacoborus/wikimatic",
		opts = {},
		config = function()
			Nmap("<leader>ww", ":Wiki<cr>", "Open [ww]iki")
			Nmap("<leader>wt", ":WikiTab<cr>", "Open [w]iki in new [t]ab")
		end,
	},

	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<leader>ot", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			-- Your setup opts here
		},
	},

	"ziglang/zig.vim",

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{ "lewis6991/gitsigns.nvim" },

	{ -- Useful plugin to show you pending keybinds.
		-- :checkhealth which-key
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		keys = {
			-- { "<leader>c", group = "[C]ode", hidden = true },
			-- { "<leader>d", group = "[D]ocument", hidden = true },
			-- { "<leader>r", group = "[R]ename", hidden = true },
			-- { "<leader>s", group = "[S]earch", hidden = true },
			-- { "<leader>w", group = "[W]orkspace", hidden = true },
		},
	},

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		-- event = 'VimEnter',
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				-- `cond` determines whether this plugin should be installed and loaded.
				cond = vim.fn.executable("make") == 1,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ -- Pretty icons, requires a Nerd Font.
				"nvim-tree/nvim-web-devicons",
				enabled = vim.g.have_nerd_font,
			},
		},
	},

	{ -- Zen Mode
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({})
		end,
	},

	{ -- copilot
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
	},

	-- {
	-- 	"b0o/incline.nvim",
	-- 	config = function()
	-- 		require("incline").setup({
	-- 			window = {
	-- 				-- margin = {
	-- 				-- 	vertical = 3,
	-- 				-- 	horizontal = 4,
	-- 				-- },
	-- 				padding = 4,
	-- 				placement = {
	-- 					horizontal = "left",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- 	-- Optional: Lazy load Incline
	-- 	event = "VeryLazy",
	-- },

	-- {
	-- 	"CopilotC-Nvim/CopilotChat.nvim",
	-- 	dependencies = {
	-- 		{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
	-- 		{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
	-- 	},
	-- 	build = "make tiktoken", -- Only on MacOS or Linux
	-- 	opts = {
	-- 		-- See Configuration section for options
	-- 		model = "claude-3.5-sonnet",
	-- 	},
	-- 	config = function(_, opts)
	-- 		require("CopilotChat").setup(opts)
	-- 	end,
	-- 	mappings = {
	-- 		complete = {
	-- 			insert = "<C-i>",
	-- 		},
	-- 	},
	-- 	keys = {
	-- 		{
	-- 			"<leader>cc",
	-- 			function()
	-- 				local actions = require("CopilotChat.actions")
	-- 				require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
	-- 			end,
	-- 			desc = "CopilotChat - Prompt actions",
	-- 			mode = "n", -- Normal mode
	-- 		},
	-- 		{
	-- 			"<leader>cc",
	-- 			function()
	-- 				local actions = require("CopilotChat.actions")
	-- 				require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
	-- 			end,
	-- 			desc = "CopilotChat - Prompt actions",
	-- 			mode = "v", -- Visual mode
	-- 		},
	-- 	},
	-- 	-- See Commands section for default commands if you want to lazy load on them
	-- },
	--
	-- {
	-- 	"yetone/avante.nvim",
	-- 	event = "VeryLazy",
	-- 	lazy = false,
	-- 	version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
	-- 	opts = {
	-- 		-- add any opts here
	-- 	},
	-- 	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- 	build = "make",
	-- 	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	-- 	dependencies = {
	-- 		"stevearc/dressing.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		--- The below dependencies are optional,
	-- 		"echasnovski/mini.pick", -- for file_selector provider mini.pick
	-- 		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
	-- 		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
	-- 		"ibhagwan/fzf-lua", -- for file_selector provider fzf
	-- 		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
	-- 		"zbirenbaum/copilot.lua", -- for providers='copilot'
	-- 		{
	-- 			-- support for image pasting
	-- 			"HakonHarnes/img-clip.nvim",
	-- 			event = "VeryLazy",
	-- 			opts = {
	-- 				-- recommended settings
	-- 				default = {
	-- 					embed_image_as_base64 = false,
	-- 					prompt_for_file_name = false,
	-- 					drag_and_drop = {
	-- 						insert_mode = true,
	-- 					},
	-- 					-- required for Windows users
	-- 					use_absolute_path = true,
	-- 				},
	-- 			},
	-- 		},
	-- 		{
	-- 			-- Make sure to set this up properly if you have lazy=true
	-- 			"MeanderingProgrammer/render-markdown.nvim",
	-- 			opts = {
	-- 				file_types = { "markdown", "Avante" },
	-- 			},
	-- 			ft = { "markdown", "Avante" },
	-- 		},
	-- 	},
	-- },
})
