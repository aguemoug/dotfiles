vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
})

-- install lldb on linux
-- sudo pacman -S lldb

local _dap_initialized = false

local function init_dap()
	if _dap_initialized then
		return
	end

	_dap_initialized = true

	local dapui = require("dapui")

	local dap = require("dap")
	dap.adapters.gdb = {
		type = "executable",
		command = "gdb",
		args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
	}
	dap.adapters.lldb = {
		type = "executable",
		command = "/usr/bin/lldb-dap", -- adjust as needed, must be absolute path
		name = "lldb",
	}
	dap.configurations.c = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			cwd = "${workspaceFolder}",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			stopOnEntry = false,
			args = {}, -- provide arguments if needed
			-- stopAtBeginningOfMainSubprogram = false,
			-- MIMode = "lldb",
		},
	}
	dap.configurations.cpp = dap.configurations.c
	-- DAP UI setup
	dapui.setup({
		icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
		controls = {
			icons = {
				pause = "⏸",
				play = "▶",
				step_into = "⏎",
				step_over = "⏭",
				step_out = "⏮",
				step_back = "b",
				run_last = "▶▶",
				terminate = "⏹",
				disconnect = "⏏",
			},
		},
	})

	-- Auto-open/close UI
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open({})
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close({})
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close({})
	end
	dap.listeners.before.disconnect["dapui_config"] = function()
		dapui.close({})
	end

	-- Virtual text
	require("nvim-dap-virtual-text").setup()
	vim.fn.sign_define("DapBreakpoint", { text = "🐞", texthl = "DiagnosticError" })
end

-- Keymaps
-- stylua: ignore start
vim.keymap.set("n", "<leader>db", function() init_dap(); require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function() init_dap(); require("dap").list_breakpoints(); vim.cmd("copen") end, { desc = "List Breakpoints" })
vim.keymap.set("n", "<leader>dc", function() init_dap(); require("dap").continue() end, { desc = "Run/Continue" })
vim.keymap.set("n", "<leader>dC", function() init_dap(); require("dap").run_to_cursor() end, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dg", function() init_dap(); require("dap").goto_() end, { desc = "Go to Line (No Execute)" })
vim.keymap.set("n", "<leader>di", function() init_dap(); require("dap").step_into() end, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dj", function() init_dap(); require("dap").down() end, { desc = "Down" })
vim.keymap.set("n", "<leader>dk", function() init_dap(); require("dap").up() end, { desc = "Up" })
vim.keymap.set("n", "<leader>dl", function() init_dap(); require("dap").run_last() end, { desc = "Run Last" })
vim.keymap.set("n", "<leader>do", function() init_dap(); require("dap").step_out() end, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dO", function() init_dap(); require("dap").step_over() end, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dP", function() init_dap(); require("dap").pause() end, { desc = "Pause" })
vim.keymap.set("n", "<leader>dr", function() init_dap(); require("dap").repl.toggle() end, { desc = "Toggle REPL" })
vim.keymap.set("n", "<leader>ds", function() init_dap(); require("dap").session() end, { desc = "Session" })
vim.keymap.set("n", "<leader>dt", function()
	init_dap()
	require("dap").terminate()
	vim.defer_fn(function()
		require("dapui").close({})
	end, 100)
end, { desc = "Terminate" })
vim.keymap.set("n", "<leader>dw", function() init_dap(); require("dap.ui.widgets").hover() end, { desc = "DAP Widgets" })
vim.keymap.set("n", "<leader>du", function() init_dap(); require("dapui").toggle({}) end, { desc = "Dap UI" })
-- stylua: ignore end
