package.path = package.path .. ";" .. os.getenv("HOME") .. "/dotfiles/nvim/?.lua"

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("mapping")
require("options")
require("plugins")
require("keymaps")