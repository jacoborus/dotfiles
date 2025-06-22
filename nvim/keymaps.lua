require("mapping")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

Nmap("gq", ":q<CR>", "Quit file")
-- Nmap("<leader><cr>", ":nohlsearch<CR>", "Clear search higlights")-- moved to plugins.lua/noice
Nmap("<leader>s", ":w<CR>", "Write file to disk")
-- vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- change buffer
Nmap("]b", ":bn<CR>", "Buffer next")
Nmap("[b", ":bp<CR>", "Buffer prev")

-- repeat last command line command
Nmap("<leader>rr", "@:<CR>", "[R]epeat last command")

-- fast copy to the end of the line
Nmap("Y", "y$", "[Y]ank (copy) till end of line")

-- resize splits faster
Nmap("<leader>>", "<C-w>10>", "Wider window")
Nmap("<leader><", "<C-w>10<", "Narrower window")
Nmap("<leader>=", "<C-w>5+", "Taller window")
Nmap("<leader>-", "<C-w>5-", "Shorter window")

-- copy/paste to/from system clipboard
Nmap("<c-p>", '"0p', "Paste from clipboard")
Nmap("<m-p>", '"0P', "Paste from clipboard alt")

-- move to the exact position on marks
Nmap("'", "`", "Move to mark exact position")
Nmap("`", "'", "Move to marked line")

-- Treat long lines as break lines
Mmap("j", "gj")
Mmap("k", "gk")

-- Move between windows
Nmap("<C-h>", "<C-W>h")
Nmap("<C-j>", "<C-W>j")
Nmap("<C-k>", "<C-W>k")
Nmap("<C-l>", "<C-W>l")
Vmap("<C-h>", "<C-W>h")
Vmap("<C-j>", "<C-W>j")
Vmap("<C-k>", "<C-W>k")
Vmap("<C-l>", "<C-W>l")

-- tab navigation with alt+l / alt+h
Nmap("<m-h>", ":tabprev<CR>", "previous tab")
Nmap("<m-l>", ":tabnext<CR>", "next tab")

-- " move up/down single lines or selected ones
Nmap("J", ":m .+1<CR>==", "move line down")
Nmap("K", ":m .-2<CR>==", "move line up")
Vmap("J", ":m '>+1<CR>gv=gv", "move line up (visual mode)")
Vmap("K", ":m '<-2<CR>gv=gv", "move line down (visual mode)")

-- Remap VIM 0 to first non-blank character
Nmap("0", "^", "go to the beginning of the line")
-- This prevents * from jumping to the next match.
Nmap("*", ":keepjumps normal! mi*`i<CR>", "highlight occurences")
-- Preserve selection after indentation
Vmap(">", ">gv", "indent")
Vmap("<", "<gv", "un-indent")
-- Map tab to indent in visual mode
Vmap("<Tab>", ">gv", "indent")
Vmap("<S-Tab>", "<gv", "un-indent")

-- fast open/close quickfix
Nmap("<leader>lo", ":lopen<cr>", "open quickfix")
Nmap("<leader>lc", ":lcl<cr>", "close quickfix")

-- -- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- ZenMode

Nmap("<leader>gz", ":ZenMode<cr>", "Open ZenMode")

-- DB UI

Nmap("<leader>db", ":tabe<cr>:DBUI<cr>", "open DBUI")
Nmap("<leader>dt", ":DBUIToggle<cr>", "open DBUI")
