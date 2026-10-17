vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
vim.opt_local.spell = false
vim.opt_local.complete:append("kspell")

vim.keymap.set("n", "<F5>", function()
	vim.cmd("write")
	local src = vim.fn.expand("%:p")
	local out = vim.fn.expand("%:p:r")
	vim.cmd("split | terminal gcc -Wall -Wextra -g -o '" .. out .. "' '" .. src .. "' && '" .. out .. "'")
	vim.cmd("startinsert")
end, { desc = "Compile and run C file" })

vim.keymap.set("n", "<leader>h", "<cmd>LspClangdSwitchSourceHeader<cr>", {
	buffer = true,
	desc = "Switch source/header",
})
