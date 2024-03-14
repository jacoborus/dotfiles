-- nvim-cmp setup
local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({})
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
Capabilities = vim.lsp.protocol.make_client_capabilities()
Capabilities = require('cmp_nvim_lsp').default_capabilities(Capabilities)

local luasnip = require 'luasnip'

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    -- Copilot Source
    { name = "copilot",  group_index = 2 },
    -- Other Sources
    { name = "nvim_lsp", group_index = 2 },
    { name = "path",     group_index = 2 },
    { name = "luasnip",  group_index = 2 },
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50,   -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      symbol_map = {
        Copilot = "",
      },
      ellipsis_char = '…', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      -- before = function(entry, vim_item)
      --   return vim_item
      -- end
    })
  },

  -- important for copilot
  -- sorting = {
  --   priority_weight = 2,
  --   comparators = {
  --     require("copilot_cmp.comparators").prioritize,
  --
  --     -- Below is the default comparitor list and order for nvim-cmp
  --     cmp.config.compare.offset,
  --     -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
  --     cmp.config.compare.exact,
  --     cmp.config.compare.score,
  --     cmp.config.compare.recently_used,
  --     cmp.config.compare.locality,
  --     cmp.config.compare.kind,
  --     cmp.config.compare.sort_text,
  --     cmp.config.compare.length,
  --     cmp.config.compare.order,
  --   },
  -- },
}
