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
