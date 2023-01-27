package.path = package.path .. ';' .. os.getenv("HOME") .. '/dotfiles/nvim/?.lua'

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("keymaps")
require("options")
require("plugins")
require("plugin_config.colors")
require("plugin_config.nvim-tree")
require("plugin_config.telescope")
require("plugin_config.comment")
require("plugin_config.indent")
require("plugin_config.gitsigns")
require("plugin_config.treesitter")
require("plugin_config.wikimatic")
require("plugin_config.ctrlsf")
require("plugin_config.completions")
require("plugin_config.lsp")
require("plugin_config.prettier")
require("plugin_config.statusline")
require("plugin_config.hlinktrace")
