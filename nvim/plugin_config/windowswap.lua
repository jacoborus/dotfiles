require('mapping')

-- Vim-windowswap
vim.g.windowswap_map_keys = 0 -- prevent default bindings

Nmap('<leader>m', ':call WindowSwap#EasyWindowSwap()<CR>', 'Swap window', { silent = true })
