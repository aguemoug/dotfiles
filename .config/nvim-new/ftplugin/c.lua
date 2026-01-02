vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true
vim.opt_local.spell = false
vim.opt_local.complete:append("kspell")

vim.keymap.set("n", "<F5>", ":make<CR>:copen<CR>", { buffer = true })
vim.keymap.set("n", "<leader>h", "<cmd>LspClangdSwitchSourceHeader<cr>", {
  buffer = true,
  desc = "Switch source/header",
})
