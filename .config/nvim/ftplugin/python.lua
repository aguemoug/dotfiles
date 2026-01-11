vim.keymap.set("n", "<F5>", ":w<CR>:!python %<CR>", {buffer = true,	desc = "Save and execute Python file",})
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldlevel = 10 -- Start with all folds open
vim.opt_local.foldnestmax = 10
vim.opt_local.foldminlines = 1

-- Auto-close folds when leaving them
vim.opt_local.foldclose = "all"
