local null_ls = require("null-ls")

require("mason-null-ls").setup({
  ensure_installed = {
    'prettierd',
    'gitsigns',
    'luasnip',
    'shfmt',
    'goimports',
    'sql_formatter',
  },
  automatic_installation = false,
  automatic_setup = false,
})

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.sql_formatter,
  },
})
