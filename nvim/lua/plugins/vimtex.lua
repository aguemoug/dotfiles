return {
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			-- Enable vimtex
			vim.g.vimtex_view_method = "zathura"

			-- Enable SyncTeX (forward search)
			vim.g.vimtex_view_general_options = "--synctex-forward @line:@pdf:@tex"

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
