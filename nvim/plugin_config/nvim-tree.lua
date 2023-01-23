require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
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
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          -- unstaged = "✖",
          -- unstaged = "⋄",
          -- unstaged = "≈",
          -- unstaged = "✕",
          unstaged = "᛭",
          -- unstaged = "×",
          staged = "•",
          unmerged = "",
          renamed = "➜",
          -- untracked = "⋆",
          -- untracked = "✶",
          -- untracked = "✱",
          untracked = "⁕",
          -- untracked = "∗",
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

vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<cr>')
