-- Setup neovim lua configuration
require('neodev').setup()

-- Setup mason so it can manage external tooling
require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = { "sumneko_lua" }
})

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local Nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  Nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  Nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  Nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  Nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  Nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  Nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  Nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  Nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  -- Nmap('<leader>k', vim.lsp.buf.hover, 'Hover Documentation')
  Nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  Nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  Nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  Nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  Nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

require("lspconfig").sumneko_lua.setup {
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}

