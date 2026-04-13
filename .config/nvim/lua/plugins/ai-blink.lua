vim.pack.add({
	{
		src = "https://github.com/BlinkResearchLabs/blink-edit.nvim",
	},
})

-- this is
-- configure immediately (IMPORTANT)
require("blink-edit").setup({
	llm = {
		provider = "sweep",
		backend = "openai",
		url = "http://127.0.0.1:8080",
		model = "sweep",
	},
})
