local function nvimtree_on_attatch(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 't', api.node.open.tab, opts('Open: New Tab'))
end

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
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
  on_attach = nvimtree_on_attatch,
})

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<cr>')
