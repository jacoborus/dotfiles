require('mapping')

vim.g.wikimatic_path = '~/wiki'

Nmap('<leader>ww', ':Wiki<cr>', 'Open wiki')
Nmap('<leader>wt', ':WikiTab<cr>', 'Open wiki in new tab')
