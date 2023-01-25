-- Gitsigns
-- See `:help gitsigns.txt`
local gitsigns = require('gitsigns')
gitsigns.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '÷' },
  },
}
Nmap('[g', ':Gitsigns prev_hunk<CR>', 'Navigate to previus git hunk' )
Nmap(']g', ':Gitsigns next_hunk<CR>', 'Navigate to next git hunk' )
-- " ⋍
