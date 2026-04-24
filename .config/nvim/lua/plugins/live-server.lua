vim.pack.add({
	"https://github.com/barrettruth/live-server.nvim.git",
})

vim.keymap.set("n", "<leader>ls", "<Plug>(live-server-start)")
