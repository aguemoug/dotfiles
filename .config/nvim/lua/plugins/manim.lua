vim.pack.add({
	"https://github.com/aguemoug/manim.nvim.git",
	"https://github.com/akinsho/toggleterm.nvim.git",
})

local m = require("manim")
m.setup()

vim.keymap.set("n", "<leader>mm", m.run_scene, { desc = "Manim: run scene to cursor" })
vim.keymap.set("n", "<leader>ml", m.reload, { desc = "Manim: reload" })
vim.keymap.set("n", "<leader>me", m.exit, { desc = "Manim: exit" })

vim.keymap.set("n", "<leader>mr", m.render, { desc = "Manim: render full animation" })

vim.keymap.set("n", "<leader>mn", m.live, { desc = "Manim: render full animation" })

vim.keymap.set("n", "<leader>mp", m.checkpoint_paste, { desc = "Manim: checkpoint paste" })
vim.keymap.set("v", "<leader>mp", m.checkpoint_paste, { desc = "Manim: checkpoint paste (visual)" })
vim.keymap.set("n", "<leader>mP", m.checkpoint_paste_recorded, { desc = "Manim: checkpoint paste (record)" })
vim.keymap.set("n", "<leader>ms", m.checkpoint_paste_skipped, { desc = "Manim: checkpoint paste (skip)" })
vim.keymap.set("n", "<leader>mo", m.open_mirrored_directory, { desc = "Manim: open mirror dir" })
