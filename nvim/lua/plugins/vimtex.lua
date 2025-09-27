return {
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		init = function()
			-- VimTeX configuration goes here, e.g.
			-- Enable vimtex
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_fold_enabled = true
			vim.g.vimtex_indent_enabled = true

			-- Enable SyncTeX (forward search)
			vim.g.vimtex_view_general_options = "--synctex-forward @line:@pdf:@tex"
			vim.g.vimtex_quickfix_mode = 2
			vim.g.vimtex_quickfix_open_on_warning = 0
			-- Open VimTeX quickfix in a new tab
			vim.api.nvim_create_augroup("vimtex_custom", { clear = true })
			vim.api.nvim_create_autocmd("User", {
				pattern = "VimtexEventQuickFix",
				callback = function()
					vim.cmd("tabnew | copen")
				end,
			})
			-- Unfold the section under the cursor wen we do inverse search from
			-- The pdf viewer
			vim.api.nvim_create_autocmd("User", {
				pattern = "VimtexEventViewReverse",
				callback = function()
					vim.cmd("normal! zM")
					vim.cmd("normal! zv")
				end,
			})
			-- Optional: Customize latexmk for better performance
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "build", -- Store output in a separate 'build' directory
				options = {
					"-pdf",
					"-interaction=nonstopmode",
					"-synctex=1",
					"-file-line-error",
				},
			}
		end,
	},
}
