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
		main = "ibl",
		opts = {
			indent = { char = "┊" },
			whitespace = {
				remove_blankline_trail = false,
			},
			scope = { enabled = false },
		},
	},

	{ "numToStr/Comment.nvim", opts = {} },

	{ -- 'jacoborus/tender.vim',
		dir = "~/dev/tender",

		config = function()
			vim.o.background = "dark"
			local colorscheme = "tender"
			local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
			if not ok then
				vim.notify("colorscheme " .. colorscheme .. " not found!")
				return
			end
		end,
	},

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"folke/neodev.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
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

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			-- notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				go = { "goimports", "gofmt" },
				lua = { "stylua" },
				markdown = { "deno_fmt" },
				python = { "isort", "black" },
				bash = { "shfmt" },
				yaml = { "yamlfix" },
				-- json = { { "prettierd", "prettier" } },
				-- javascript = { { "prettierd", "prettier" } },
			},
		},
	},

	{ -- notifications, messages, cmdline and the popupmenu
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
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
				ensure_installed = { "bash", "c", "html", "lua", "markdown", "vim", "vimdoc" },
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

	"simrat39/symbols-outline.nvim",
	"ziglang/zig.vim",

	-- Git related plugins
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{ "lewis6991/gitsigns.nvim" },

	{ -- Useful plugin to show you pending keybinds.
		-- :checkhealth which-key
		"folke/which-key.nvim",
		event = "VimEnter",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function()
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			})
		end,
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
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
