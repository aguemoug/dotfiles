vim.opt.compatible = false -- disable legacy vi
-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- mouse support

vim.opt.showmode = false
-- enable utf-8
vim.opt.encoding = "utf-8" -- internal Vim encoding
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
vim.opt.wrap = true
vim.opt.linebreak = false
vim.opt.breakindent = false
--vim.opt.showbreak = "↳ " -- optional: show a small indicator for wrap
vim.opt.textwidth = 0
vim.opt.wrapmargin = 2 -- start wrapping 2 chars before window edge
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

vim.o.makeprg = "bash make.sh"

vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.opt.compatible = false -- disable legacy vi
-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- mouse support

vim.opt.showmode = false
-- enable utf-8
vim.opt.encoding = "utf-8" -- internal Vim encoding
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
vim.opt.wrap = true
vim.opt.linebreak = false
vim.opt.breakindent = false
--vim.opt.showbreak = "↳ " -- optional: show a small indicator for wrap
vim.opt.textwidth = 0
vim.opt.wrapmargin = 2 -- start wrapping 2 chars before window edge
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

vim.o.makeprg = "bash make.sh"

vim.opt.spell = true


