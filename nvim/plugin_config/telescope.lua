-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { ".git/*" },
    mappings = {
      i = {
        ['<C-j>'] = "move_selection_next",
        ['<C-k>'] = "move_selection_previous",
      },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case"
    },
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown(),
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')

local builtin = require('telescope.builtin')

local function find_files()
  builtin.find_files({ hidden = true })
end

vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymap definitions' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind existing [B]uffers' })
-- vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>p', find_files, { desc = 'Find [F]iles' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [h]elp' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = '[/] Fuzzily search in current buffer]' })
