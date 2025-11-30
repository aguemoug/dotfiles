local M = {}

function M.setup()
	-- Python filetype-specific settings
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "python",
		callback = function()
			print("Python folding enabled: " .. vim.opt_local.foldmethod:get())
		end,
	})

	-- Global folding keymaps
	vim.keymap.set("n", "<leader>zc", "zc", { desc = "Close fold" })
	vim.keymap.set("n", "<leader>zo", "zo", { desc = "Open fold" })
	vim.keymap.set("n", "<leader>za", "za", { desc = "Toggle fold" })
	vim.keymap.set("n", "<leader>zR", "zR", { desc = "Open all folds" })
	vim.keymap.set("n", "<leader>zM", "zM", { desc = "Close all folds" })
	vim.keymap.set("n", "<leader>zr", "zr", { desc = "Open one more fold level" })
	vim.keymap.set("n", "<leader>zm", "zm", { desc = "Close one more fold level" })
end

return M
