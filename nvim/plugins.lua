local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- these lines need to load before Lazy, otherwise ignored
vim.g.wikimatic_path = '~/wiki'
vim.g.windowswap_map_keys = 0 -- prevent default bindings

require('mapping')

require('lazy').setup({
  "onsails/lspkind.nvim",
  'gerw/vim-HiLinkTrace',
  'christoomey/vim-tmux-navigator',
  'AndrewRadev/tagalong.vim',
  'tpope/vim-surround',
  'dyng/ctrlsf.vim',
  'jiangmiao/auto-pairs',
  'caenrique/swap-buffers.nvim',
  'nvim-lualine/lualine.nvim',           -- Fancier statusline,
  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines,
  { 'numToStr/Comment.nvim', opts = {} },
  'tpope/vim-sleuth',                    -- Detect tabstop and shiftwidth automatically,
  { dir = '~/dev/tender' },
  -- 'jacoborus/tender.vim',


  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'folke/neodev.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
    },
  },

  { -- Highlight todo, notes, etc in comments
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },

  { -- LSP Configuration & Plugins
    'jose-elias-alvarez/null-ls.nvim',
    dependencies = {
      'jay-babu/mason-null-ls.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/nvim-treesitter-context',
    },
  },

  { -- the file tree
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  },

  {
    'wesQ3/vim-windowswap',
    config = function()
      Nmap('<leader>m', ':call WindowSwap#EasyWindowSwap()<CR>', 'Swap window', { silent = true })
    end
  },

  {
    'jacoborus/wikimatic',
    opts = {},
    config = function()
      Nmap('<leader>ww', ':Wiki<cr>', 'Open wiki')
      Nmap('<leader>wt', ':WikiTab<cr>', 'Open wiki in new tab')
    end
  },

  'simrat39/symbols-outline.nvim',
  'ziglang/zig.vim',

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  { 'lewis6991/gitsigns.nvim', },

  { -- Useful plugin to show you pending keybinds.
    -- :checkhealth which-key
    'folke/which-key.nvim',
    event = 'VimEnter',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function()
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    -- event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',

        -- `cond` determines whether this plugin should be installed and loaded.
        cond = vim.fn.executable 'make' == 1
      },

      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font
      },
    },
  },

  { -- Zen Mode
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
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
        -- after = { "copilot.lua" },
        config = function()
          require("copilot_cmp").setup()
        end
      },
    }
  },



}, {
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
