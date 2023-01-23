function Map(mode, lhs, rhs, desc, opts)
    local options = {
      noremap = true,
      desc = desc,
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function Nmap(lhs, rhs, desc, opts)
  Map('n', lhs, rhs, desc, opts)
end

function Vmap(lhs, rhs, desc, opts)
  Map('v', lhs, rhs, desc, opts)
end

function Imap(lhs, rhs, desc, opts)
  Map('i', lhs, rhs, desc, opts)
end
