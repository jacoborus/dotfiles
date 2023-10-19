local null_ls = require("null-ls")

require("mason-null-ls").setup({
  ensure_installed = {
    'gitsigns',
    'goimports',
    'luasnip',
    'eslint',
    'prettierd',
    -- 'rustfmt',
    'shfmt',
    'sql_formatter',
  },
  automatic_installation = false,
  automatic_setup = false,
})

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.code_actions.eslint,
    -- null_ls.builtins.formatting.eslint,
    -- null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.sql_formatter,
  },
})
