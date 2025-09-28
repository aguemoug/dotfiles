-- lua/manim_nvim/init.lua
local M = {}

-- Helper: find nearest class above cursor
local function get_command()
	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	row = row - 1 -- 0-indexed

	local class_lines = {}
	for i, line in ipairs(lines) do
		local match = line:match("^class%s+([%w_]+)%s*%b():") or line:match("^class%s+([%w_]+)%s*:")
		if match then
			table.insert(class_lines, { line = line, idx = i - 1 })
		end
	end

	if #class_lines == 0 then
		vim.notify("No class definitions found", vim.log.levels.ERROR)
		return nil
	end

	-- find last class before cursor
	local scene_line = nil
	local scene_name = nil
	for i = #class_lines, 1, -1 do
		if class_lines[i].idx <= row then
			scene_line = class_lines[i].idx
			scene_name = class_lines[i].line:match("^class%s+([%w_]+)")
			break
		end
	end

	if not scene_name then
		vim.notify("No matching class above cursor", vim.log.levels.ERROR)
		return nil
	end

	local file = vim.api.nvim_buf_get_name(buf)
	local cmd = { "manimgl", file, scene_name }

	if row ~= scene_line then
		table.insert(cmd, "-se")
		table.insert(cmd, tostring(row + 1))
	end

	return table.concat(cmd, " ")
end
-- --- detection function
function M.is_manim_file(buf)
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	for _, line in ipairs(lines) do
		if line:match("^%s*import%s+manim") or line:match("^%s*from%s+manim") then
			return true
		end
	end
	return false
end

-- Run in terminal
function M.run_scene()
	vim.cmd("write") -- save file
	local command = get_command()
	if not command then
		return
	end

	-- open/reuse terminal
	if not M.term_buf or not vim.api.nvim_buf_is_valid(M.term_buf) then
		vim.cmd("split | terminal")
		M.term_buf = vim.api.nvim_get_current_buf()
		M.term_chan = vim.b.terminal_job_id
	end

	-- send command
	vim.fn.chansend(M.term_chan, command .. "\n")
	vim.notify("Running: " .. command)
end

-- Exit manim session
function M.exit()
	if M.term_chan then
		vim.fn.chansend(M.term_chan, "\003quit\n")
	end
end

-- Checkpoint paste helpers
function M.checkpoint_paste(arg)
	local mode = vim.fn.mode()
	local reg = vim.fn.getreg('"')
	local lines = vim.split(reg, "\n")
	local first_line = vim.trim(lines[1])

	local command = ""
	if #lines == 1 and not first_line:match("^#") then
		command = reg
	else
		local comment = first_line:match("^#") and first_line or "#"
		command = string.format("checkpoint_paste(%s) %s (%d lines)", arg or "", comment, #lines)
	end

	if M.term_chan then
		vim.fn.chansend(M.term_chan, command .. "\n")
	end
end
function M.clear_scene()
	if M.term_chan then
		vim.fn.chansend(M.term_chan, "reload() \n")
	end
end
function M.enable_manim()
	vim.api.nvim_create_user_command("ManimRunScene", M.run_scene, {})
	vim.api.nvim_create_user_command("ManimExit", M.exit, {})
	vim.api.nvim_create_user_command("ManimClear", M.clear_scene, {})
	vim.api.nvim_create_user_command("ManimCheckpointPaste", function()
		M.checkpoint_paste()
	end, {})
	vim.api.nvim_create_user_command("ManimRecordedCheckpointPaste", function()
		M.checkpoint_paste("record=True")
	end, {})
	vim.api.nvim_create_user_command("ManimSkippedCheckpointPaste", function()
		M.checkpoint_paste("skip=True")
	end, {})
	vim.keymap.set("n", "<F5>", function()
		M.run_scene()
	end, { desc = "Run current Manim scene" })

	-- Corrected leader mappings (use <leader> without + signs)
	vim.keymap.set("n", "<leader>r", function()
		vim.cmd("normal! yy")
		M.checkpoint_paste()
	end, { desc = "Run selected code" })

	vim.keymap.set("v", "<leader>r", function()
		vim.cmd("normal! y")
		M.checkpoint_paste()
	end, { desc = "Run selected code" })

	vim.keymap.set("n", "<leader>c", function()
		M.clear_scene()
	end, { desc = "clear scene" })

	vim.keymap.set("n", "<leader>q", function()
		M.exit()
	end, { desc = "exit scene" })
end

return M
