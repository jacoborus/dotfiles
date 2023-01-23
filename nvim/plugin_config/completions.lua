local cmp = require('cmp')

cmp.setup({
})
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
Capabilities = vim.lsp.protocol.make_client_capabilities()
Capabilities = require('cmp_nvim_lsp').default_capabilities(Capabilities)

