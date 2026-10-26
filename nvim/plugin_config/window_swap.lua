-- Intercambia buffers entre dos ventanas sin tocar el layout ni los tamaños,
-- igual que hacía vim-windowswap. Dos pasos: marcar y luego intercambiar.
local M = {}

---@type { tab: integer, win: integer }?
local marked = nil

local function notify(msg, level)
	vim.notify("Swap: " .. msg, level or vim.log.levels.INFO)
end

---Intercambia los buffers de dos ventanas conservando la vista de cada buffer.
---@param win_a integer
---@param win_b integer
local function swap_buffers(win_a, win_b)
	local view_a = vim.api.nvim_win_call(win_a, vim.fn.winsaveview)
	local view_b = vim.api.nvim_win_call(win_b, vim.fn.winsaveview)
	local buf_a = vim.api.nvim_win_get_buf(win_a)
	local buf_b = vim.api.nvim_win_get_buf(win_b)

	vim.api.nvim_win_set_buf(win_a, buf_b)
	vim.api.nvim_win_set_buf(win_b, buf_a)

	-- La vista viaja con el buffer, no con la ventana.
	vim.api.nvim_win_call(win_a, function()
		vim.fn.winrestview(view_b)
	end)
	vim.api.nvim_win_call(win_b, function()
		vim.fn.winrestview(view_a)
	end)
end

function M.easy_swap()
	local cur_tab = vim.api.nvim_get_current_tabpage()
	local cur_win = vim.api.nvim_get_current_win()

	if not marked then
		marked = { tab = cur_tab, win = cur_win }
		notify("ventana marcada. Ve a la otra y pulsa <leader>m")
		return
	end

	local src = marked
	marked = nil

	if not vim.api.nvim_win_is_valid(src.win) then
		notify("la ventana marcada ya no existe; marca otra vez", vim.log.levels.WARN)
		return
	elseif src.tab ~= cur_tab or vim.api.nvim_win_get_tabpage(src.win) ~= cur_tab then
		notify("cambiaste de pestaña; marca otra vez", vim.log.levels.WARN)
		return
	elseif src.win == cur_win then
		notify("marca cancelada")
		return
	end

	swap_buffers(cur_win, src.win)
end

M.clear = function()
	marked = nil
end

return M
