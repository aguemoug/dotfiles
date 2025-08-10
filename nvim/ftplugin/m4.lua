vim.cmd 'set filetype=cm'
local circuitmacro = require 'custom.m4'
vim.api.nvim_create_user_command('Mkcircuit', circuitmacro.compile_m4_to_png, {
  desc = 'Compile M4 file to PNG using circuit macros',
})
vim.keymap.set('n', '<F5>', circuitmacro.toggle_continuous_compile, { silent = true, desc = 'Toggle continuous M4 compilation' })
