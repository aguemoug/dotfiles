return {
	-- Tokyo Night
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"projekt0n/github-nvim-theme",
		name = "github-theme",
		lazy = false,
		priority = 1000,
	},

	-- Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 999,
	},

	-- Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		lazy = false,
		priority = 998,
	},

	-- Nightfox
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 997,
	},

	-- Activate ONE theme here
	{
		"nvim-lua/plenary.nvim", -- dummy entry to run config last
		config = function()
			-- 🎨 Choose your preferred colorscheme here:
			-- vim.cmd.colorscheme("tokyonight")
			--vim.cmd.colorscheme("catppuccin")
			--vim.cmd.colorscheme("gruvbox")
			--vim.cmd.colorscheme("carbonfox") -- one of Nightfox variants
			vim.cmd.colorscheme("github_dark_default") -- one of Nightfox variants
		end,
	},
}
