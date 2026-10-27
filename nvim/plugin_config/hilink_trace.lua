-- Reimplementación de vim-HiLinkTrace: muestra la pila de syntax, los
-- captures de treesitter y la cadena de links del grupo bajo el cursor.
local M = {}

local function hex(value)
	if type(value) == "number" then
		return string.format("#%06x", value)
	end
	return "none"
end

local function link_chain(name)
	local chain = { name }
	local seen = { [name] = true }
	for _ = 1, 10 do
		local hl = vim.api.nvim_get_hl(0, { name = chain[#chain], link = true })
		local link = hl and hl.link
		if not link or seen[link] then
			break
		end
		chain[#chain + 1] = link
		seen[link] = true
	end
	return chain
end

local function syntax_stack(row, col)
	local names = {}
	for _, id in ipairs(vim.fn.synstack(row, col + 1)) do
		local name = vim.fn.synIDattr(id, "name")
		if name ~= "" then
			names[#names + 1] = name
		end
	end
	return names
end

local function treesitter_stack(row, col)
	local ok, info = pcall(vim.inspect_pos, 0, row - 1, col)
	if not ok or not info or not info.treesitter then
		return {}, nil
	end

	local names = {}
	local group = nil
	for _, item in ipairs(info.treesitter) do
		local lang = item.lang or vim.bo.filetype
		local name = "@" .. (item.capture or "?") .. "." .. lang
		if item.hl_group_link and item.hl_group_link ~= name then
			name = name .. "->" .. item.hl_group_link
		end
		names[#names + 1] = name
		group = item.hl_group_link or item.hl_group or group
	end
	return names, group
end

function M.get_trace()
	local pos = vim.api.nvim_win_get_cursor(0)
	local row, col = pos[1], pos[2]
	local syn = syntax_stack(row, col)
	local ts, ts_group = treesitter_stack(row, col)
	local group = syn[#syn] or ts_group

	local parts = {
		"SynStack: " .. (#syn > 0 and table.concat(syn, "->") or "-"),
		"TS: " .. (#ts > 0 and table.concat(ts, "->") or "-"),
	}

	if group then
		local chain = link_chain(group)
		local hl = vim.api.nvim_get_hl(0, { name = chain[#chain] })
		parts[#parts + 1] = "Trace: " .. table.concat(chain, "->")
		parts[#parts + 1] = string.format("fg<%s> bg<%s>", hex(hl and hl.fg), hex(hl and hl.bg))
	else
		parts[#parts + 1] = "no highlight at cursor"
	end

	return table.concat(parts, " | ")
end

function M.trace(opts)
	opts = opts or {}
	vim.api.nvim_echo({ { M.get_trace(), "None" } }, opts.history ~= false, {})
end

local hlt_group = vim.api.nvim_create_augroup("HLTMode", { clear = true })
local hlt_active = false

function M.toggle()
	hlt_active = not hlt_active
	if hlt_active then
		vim.api.nvim_create_autocmd("CursorMoved", {
			group = hlt_group,
			callback = function()
				M.trace({ history = false })
			end,
		})
		vim.notify("HLT mode ON", vim.log.levels.INFO)
	else
		vim.api.nvim_clear_autocmds({ group = hlt_group })
		vim.notify("HLT mode OFF", vim.log.levels.INFO)
	end
end

vim.api.nvim_create_user_command("HLT", function(cmd)
	if cmd.bang then
		M.toggle()
	else
		M.trace({ history = true })
	end
end, { bang = true, force = true, desc = "Trace highlight links and syntax stack at cursor" })

vim.api.nvim_create_user_command("HLTm", M.toggle, {
	force = true,
	desc = "Toggle HLT cursor-move mode",
})

return M
