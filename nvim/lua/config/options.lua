
-- disable legacy vi
vim.opt.compatible = false

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- mouse support
vim.opt.mouse = "a"

-- showmode off (if you use statusline plugins)
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
vim.opt.signcolumn = 'yes'

-- performance tweaks
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- incremental substitution preview
vim.opt.inccommand = 'split'

-- cursor line highlighting off (change if you want it)
vim.opt.cursorline = false

-- keep some context when scrolling
vim.opt.scrolloff = 10

-- confirm before closing unsaved buffers
vim.opt.confirm = true

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- clipboard sync with system
vim.opt.clipboard = 'unnamedplus'

