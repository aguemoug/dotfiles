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

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp" },
	callback = function(args)
		vim.opt_local.spell = false
		vim.opt_local.complete:append("kspell")
	end,
})

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

			-- Method 1: Treesitter folding (recommended)
			vim.opt_local.foldmethod = "expr"
			vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"

			-- Method 2: Indent folding (alternative - sometimes works better for Python)
			-- vim.opt_local.foldmethod = "indent"

			vim.opt_local.foldlevel = 10 -- Start with all folds open
			vim.opt_local.foldnestmax = 10
			vim.opt_local.foldminlines = 1

			-- Auto-close folds when leaving them
			vim.opt_local.foldclose = "all"
		end
	end,
})

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

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local args = vim.fn.argv()
		if #args == 1 then
			local stat = vim.loop.fs_stat(args[1])
			if stat and stat.type == "directory" then
				vim.cmd("Neotree filesystem reveal left")
			end
		end
	end,
})
