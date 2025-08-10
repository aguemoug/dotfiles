-- init.lua
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.keymaps")
require("config.options")
require("config.lazy")
vim.lsp.enable("ltex_plus")
