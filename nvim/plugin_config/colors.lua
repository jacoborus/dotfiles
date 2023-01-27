vim.o.background = 'dark'
-- vim.cmd [[ colorscheme tender ]]
local colorscheme = "tender"
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
vim.o.background = "dark" -- or "light" for light mode
if not ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
