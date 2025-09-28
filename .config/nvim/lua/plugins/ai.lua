return {
	{
		"ggml-org/llama.vim",
		enabled = false,
		init = function()
			vim.g.llmma_config = {
				endpoint = "http://127.0.0.1:8080",
				api_key = "",
			}
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		enabled = false,
		event = "VeryLazy",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					accept = false,
				},
				panel = {
					enabled = false,
				},
				filetypes = {
					markdown = true,
					help = true,
					html = true,
					tex = false,
					javascript = true,
					typescript = true,
					["*"] = true,
				},
			})

			vim.keymap.set("i", "<Tab>", function()
				if require("copilot.suggestion").is_visible() then
					require("copilot.suggestion").accept()
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
				end
			end, {
				silent = true,
			})
		end,
	},
}
