-- init.lua
-- keymapings

-- Set space as the global leader key
vim.g.mapleader = " "
-- Set space as the local leader key (for buffer-specific mappings)
vim.g.maplocalleader = " "

vim.opt.compatible = false -- disable legacy vi
-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- mouse support

vim.opt.showmode = false

-- indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- colors
vim.opt.termguicolors = true

-- break indent
vim.opt.breakindent = true

-- undo file
vim.opt.undofile = true

-- keep signcolumn always visible
vim.opt.signcolumn = "yes"

-- performance tweaks
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- incremental substitution preview
vim.opt.inccommand = "split"

-- cursor line highlighting off (change if you want it)
vim.opt.cursorline = true

-- keep some context when scrolling
vim.opt.scrolloff = 10

-- confirm before closing unsaved buffers
vim.opt.confirm = true

-- vim.cmd("syntax enable")
-- vim.cmd("filetype plugin indent on")

-- clipboard sync with system
vim.opt.clipboard = "unnamedplus"

vim.o.makeprg = "cmake --build build"
-- Normal mode mappings:
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "[W]rite/Save current file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "[Q]uit current window" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "[P]aste from system clipboard after cursor" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "[P]aste from system clipboard before cursor" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "[Y]ank to system clipboard" })

-- Visual mode mappings:
vim.keymap.set("v", "<leader>y", '"+y', { desc = "[Y]ank selection to system clipboard" })

-- Normal mode utility mappings:
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Save current file (Ctrl+S)" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Terminal mode mappings:
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation mappings:
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-BS>", "<C-w>", { desc = "Move focus to the upper window" })

-- LATEX SPECIFIC MAPPINGS
vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
		vim.keymap.set("n", "<F5>", ":w<CR>:VimtexCompile<CR>", { buffer = true })
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function(args)
		-- buffer-local mapping
		vim.keymap.set("n", "<F5>", ":make<CR>:copen<CR>", { buffer = true })
	end,
})

-- Basic spell check
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
-- Spell Cheking
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function(args)
		vim.opt_local.spell = true
		vim.opt_local.complete:append("kspell")
	end,
})

---------------------------
--- M4 SPECIFIC MAPPINGS
---
---------------------------
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.m4",
	callback = function()
		-- Set filetype (creates buffer-local settings)
		vim.cmd("set filetype=cm")

		-- Load circuit macros module
		local circuitmacro = require("custom.m4")

		-- Create user command for manual compilation
		vim.api.nvim_buf_create_user_command(0, "Mkcircuit", circuitmacro.compile_m4_to_png, {
			desc = "Compile M4 file to PNG using circuit macros",
		})

		-- Set buffer-local keymap for F5
		vim.keymap.set("n", "<F5>", circuitmacro.toggle_continuous_compile, {
			buffer = true, -- Make it buffer-local
			silent = true,
			desc = "Toggle continuous M4 compilation",
		})

		-- Optional: Set other M4-specific settings
		vim.opt_local.commentstring = "dnl %s" -- M4 comment syntax
	end,
})

---------------------------------------
---  PYTHON SPECIFIC MAPPINGS
---
---------------------------------------
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function(args)
		local manim = require("custom.manim")
		if manim.is_manim_file(args.buf) then
			print("Detected manim file")
			manim.enable_manim()
		else
			vim.keymap.set("n", "<F5>", ":w<CR>:!python %<CR>", {
				buffer = true,
				desc = "Save and execute Python file",
			})
		end
	end,
})

----------------------------------------
--- LAZY VIM
---
----------------------------------------
-- Install lazy.nvim if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ "tpope/vim-sleuth" }, -- Detect tabstop and shiftwidth automatically

		-- Import all plugin specs from lua/plugins/
		{ import = "plugins" },
	},
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

vim.lsp.enable("ltex_plus")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
