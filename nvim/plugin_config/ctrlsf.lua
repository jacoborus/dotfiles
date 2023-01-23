require('mapping')

-- CtrlSF
-- --------------------------
vim.g.ctrlsf_auto_focus = {
  at = "start"
}

Nmap('<leader>ff',  ':CtrlSF<space>')
Nmap('<leader>fo',  ':CtrlSFOpen<cr>')
Nmap('<leader>fe',  '<Plug>CtrlSFVwordExec')
Nmap('<leader>ft',  ':CtrlSFToggle<cr>')
