require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "s", action = "vsplit" },
        { key = "t", action = "tabnew" },
      },
    },
  },
  renderer = {
    group_empty = true,
    icons = {
      webdev_colors = false,
      show = {
        file = false,
        folder = false,
      },
      glyphs = {
        folder = {
          arrow_closed = "",
          arrow_open = "",
          -- arrow_closed = "",
          -- arrow_closed = "▸",
          -- arrow_open = "",
          -- arrow_open = "▾",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          -- ⋄∘๐••✕✖✱⁕∗✦✶✧⚬⠶๑▪๏⌾⋄⬥⊚᛭•∘⋆˖⬢ ✓≈➜≈✕➜✕
          unstaged = "≈",
          -- staged = "๏", -- ✓๏
          staged = "✓", -- ✓๏
          unmerged = "",
          renamed = "➜",
          untracked = "∗",
          deleted = "␡",
          ignored = "◌",
        }
      }
    }
  },
  filters = {
    dotfiles = true,
  },
})

-- local api = require('nvim-tree.api')

-- local function opts(desc)
--   return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
-- end
--
-- vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
-- vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<cr>')
