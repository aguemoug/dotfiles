vim.g.mapleader = " "

local keymap = vim.keymap.set

-- Normal mode utility mappings:
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
keymap("n", "<C-s>", ":w<CR>", { desc = "Save current file (Ctrl+S)" })

-- Terminal mode mappings:
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation mappings:
keymap("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
keymap("n", "<C-BS>", "<C-w>", { desc = "Move focus to the upper window" })
