return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = 1000,
	},
	keys = {
		-- Show buffer-local which-key
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps",
		},

		-- Telescope
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<F3>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<F4>", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },

		-- Neo-tree
		{ "<leader>ee", "<cmd>Neotree toggle reveal<cr>", desc = "Toggle File Explorer" },
		{ "<leader>eg", "<cmd>Neotree git_status<cr>", desc = "Git Status" },
		{ "<leader>es", "<cmd>Neotree symbols<cr>", desc = "LSP Symbols" },

		-- DAP / Debugger
		{
			"<leader>dt",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
		{
			"<leader>db",
			function()
				require("dap").list_breakpoints()
			end,
			desc = "List Breakpoints",
		},
		{
			"<leader>de",
			function()
				require("dap").set_exception_breakpoints({ "all" })
			end,
			desc = "Exception Breakpoints",
		},
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Continue",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step Into",
		},
		{
			"<leader>ds",
			function()
				require("dap").step_over()
			end,
			desc = "Step Over",
		},
		{
			"<leader>du",
			function()
				require("dap").step_out()
			end,
			desc = "Step Out",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.open()
			end,
			desc = "Open REPL",
		},
		{
			"<leader>dl",
			function()
				require("dap").run_last()
			end,
			desc = "Run Last",
		},
		{
			"<leader>dq",
			function()
				require("dap").terminate()
				pcall(require("dapui").close)
				require("nvim-dap-virtual-text").toggle()
			end,
			desc = "Terminate",
		},

		-- Build / CMake
		{ "<leader>mb", ":make<CR>", desc = "Build project (CMake)" },
		{ "<leader>mc", ":make<CR>:copen<CR>", desc = "Build + show errors" },

		-- Clipboard / Utility
		{ "<leader>w", "<cmd>w<cr>", desc = "Save current file" },
		{ "<leader>q", "<cmd>q<cr>", desc = "Quit current window" },
		{ "<leader>Q", vim.diagnostic.setloclist, desc = "Open diagnostic quickfix list" },
		{ "<leader>p", '"+p', desc = "Paste after cursor" },
		{ "<leader>P", '"+P', desc = "Paste before cursor" },
		{ "<leader>y", '"+y', desc = "Yank to system clipboard", mode = { "n", "v" } },
	},
	config = function()
		local wk = require("which-key")
		-- Register group names for discoverable menus
		wk.register({
			{ "<leader>f", group = "find" }, -- group
			{ "<leader>e", group = "Explorer" }, -- group
			{ "<leader>d", group = "Debugger" }, -- group
			{ "<leader>m", group = "Build" }, -- group
			{ "<leader>w", group = "file / save" }, -- group
		})
	end,
}
