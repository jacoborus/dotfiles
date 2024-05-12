package.path = package.path .. ";" .. os.getenv("HOME") .. "/dotfiles/nvim/?.lua"

require("keymaps")
require("options")
require("plugins")
require("plugin_config.nvim-tree")
require("plugin_config.gitsigns")
require("plugin_config.telescope")
require("plugin_config.treesitter")
require("plugin_config.completions")
require("plugin_config.lsp")
require("plugin_config.statusline")
