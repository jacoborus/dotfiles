vim.keymap.set("n", "gq", ":q<CR>", { desc = "Quit file", silent = true })
vim.keymap.set("n", "<leader>s", "<cmd>update<CR>", { desc = "Update file to disk", silent = true })

-- change buffer
vim.keymap.set("n", "]b", ":bn<CR>", { desc = "Buffer next", silent = true })
vim.keymap.set("n", "[b", ":bp<CR>", { desc = "Buffer prev", silent = true })

-- repeat last command line command
vim.keymap.set("n", "<leader>rr", "@:<CR>", { desc = "[R]epeat last command" })

-- fast copy to the end of the line
vim.keymap.set("n", "Y", "y$", { desc = "[Y]ank (copy) till end of line" })

-- resize splits faster
vim.keymap.set("n", "<leader>>", "<C-w>10>", { desc = "Wider window" })
vim.keymap.set("n", "<leader><", "<C-w>10<", { desc = "Narrower window" })
vim.keymap.set("n", "<leader>=", "<C-w>5+", { desc = "Taller window" })
vim.keymap.set("n", "<leader>-", "<C-w>5-", { desc = "Shorter window" })

-- copy/paste to/from system clipboard
vim.keymap.set("n", "<c-p>", '"0p', { desc = "Paste from clipboard" })
vim.keymap.set("v", "<c-p>", '"0p', { desc = "Paste from clipboard" })
vim.keymap.set("n", "<m-p>", '"0P', { desc = "Paste from clipboard alt" })

-- move to the exact position on marks
vim.keymap.set("n", "'", "`", { desc = "Move to mark exact position" })
vim.keymap.set("n", "`", "'", { desc = "Move to marked line" })

-- Treat long lines as break lines
vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")

-- Scroll wheel
vim.keymap.set("n", "<ScrollWheelUp>", "<C-y>", { silent = true })
vim.keymap.set("n", "<ScrollWheelDown>", "<C-e>", { silent = true })
vim.keymap.set("i", "<ScrollWheelUp>", "<C-y>", { silent = true })
vim.keymap.set("i", "<ScrollWheelDown>", "<C-e>", { silent = true })
vim.keymap.set("v", "<ScrollWheelUp>", "<C-y>", { silent = true })
vim.keymap.set("v", "<ScrollWheelDown>", "<C-e>", { silent = true })

-- Move between windows
vim.keymap.set("n", "<C-h>", "<C-W>h")
vim.keymap.set("n", "<C-j>", "<C-W>j")
vim.keymap.set("n", "<C-k>", "<C-W>k")
vim.keymap.set("n", "<C-l>", "<C-W>l")
vim.keymap.set("v", "<C-h>", "<C-W>h")
vim.keymap.set("v", "<C-j>", "<C-W>j")
vim.keymap.set("v", "<C-k>", "<C-W>k")
vim.keymap.set("v", "<C-l>", "<C-W>l")

-- tab navigation with alt+l / alt+h
vim.keymap.set("n", "<m-h>", ":tabprev<CR>", { desc = "previous tab", silent = true })
vim.keymap.set("n", "<m-l>", ":tabnext<CR>", { desc = "next tab", silent = true })

-- " move up/down single lines or selected ones
vim.keymap.set("n", "J", ":m .+1<CR>==", { desc = "move line down", silent = true })
vim.keymap.set("n", "K", ":m .-2<CR>==", { desc = "move line up", silent = true })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move line up (visual mode)", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move line down (visual mode)", silent = true })

-- Remap VIM 0 to first non-blank character
vim.keymap.set("n", "0", "^", { desc = "go to the beginning of the line" })
-- This prevents * from jumping to the next match.
vim.keymap.set("n", "*", ":keepjumps normal! mi*`i<CR>", { desc = "highlight occurences" })
-- Preserve selection after indentation
vim.keymap.set("v", ">", ">gv", { desc = "indent" })
vim.keymap.set("v", "<", "<gv", { desc = "un-indent" })
-- Map tab to indent in visual mode
vim.keymap.set("v", "<Tab>", ">gv", { desc = "indent" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "un-indent" })

-- fast open/close quickfix
vim.keymap.set("n", "<leader>lo", ":lopen<cr>", { desc = "open quickfix" })
vim.keymap.set("n", "<leader>lc", ":lcl<cr>", { desc = "close quickfix" })

-- -- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- ZenMode

vim.keymap.set("n", "<leader>gz", ":ZenMode<cr>", { desc = "Open ZenMode", silent = true })

-- DB UI

vim.keymap.set("n", "<leader>db", ":tabe<cr>:DBUI<cr>", { desc = "open DBUI", silent = true })
vim.keymap.set("n", "<leader>dt", ":DBUIToggle<cr>", { desc = "open DBUI", silent = true })
