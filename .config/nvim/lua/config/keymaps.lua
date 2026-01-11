vim.g.mapleader = " "
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local map = vim.keymap.set

-- Tab/Shift-Tab: Like browser tabs, feels natural
map("n", "<Tab>", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous buffer" })
-- Alternative buffer switching (vim-style)
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- Quick switch to last edited file (super useful!)
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Move between windows with Ctrl+hjkl (like tmux)
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize windows with Ctrl+Shift+arrows (macOS friendly)
map("n", "<C-S-Up>", "<cmd>resize +5<CR>", opts)
map("n", "<C-S-Down>", "<cmd>resize -5<CR>", opts)
map("n", "<C-S-Left>", "<cmd>vertical resize -5<CR>", opts)
map("n", "<C-S-Right>", "<cmd>vertical resize +5<CR>", opts)

-- Move lines up/down (Alt+j/k like VSCode)
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
-- Window splitting
map("n", "<leader>ww", "<C-W>p", { desc = "Other Window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>sh", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>sv", "<C-W>v", { desc = "Split Window Right", remap = true })

-- Better line start/end (more comfortable than $ and ^)
map("n", "gl", "$", { desc = "Go to end of line" })
map("n", "gh", "^", { desc = "Go to start of line" })
map("n", "<A-h>", "^", { desc = "Go to start of line", silent = true })
map("n", "<A-l>", "$", { desc = "Go to end of line", silent = true })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Better paste (doesn't replace clipboard with deleted text)
map("v", "p", '"_dP', opts)

-- Copy whole file to clipboard
map("n", "<C-c>", ":%y+<CR>", opts)

-- Smart undo break-points (create undo points at logical stops)
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- Auto-close pairs (simple, no plugin needed)
map("i", "`", "``<left>")
map("i", '"', '""<left>')
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "<", "<><left>")
-- Note: Single quotes commented out to avoid conflicts in some contexts
-- map("i", "'", "''<left>")

-- ═══════════════════════════════════════════════════════════
-- FILE OPERATIONS
-- ═══════════════════════════════════════════════════════════

-- Save file (works in all modes)
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Create new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Quit operations
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- ═══════════════════════════════════════════════════════════
-- DEVELOPMENT TOOLS
-- ═══════════════════════════════════════════════════════════

-- Commenting (add comment above/below current line)
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- Quickfix and location lists
map("n", "<leader>xl", function()
	local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Location List" })

map("n", "<leader>xq", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Inspection tools (useful for debugging highlights and treesitter)
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- Keyword program (K for help on word under cursor)
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- ═══════════════════════════════════════════════════════════
-- TERMINAL INTEGRATION
-- ═══════════════════════════════════════════════════════════

-- Terminal mode navigation
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- ═══════════════════════════════════════════════════════════
-- TAB MANAGEMENT (when you need multiple workspaces)
-- ═══════════════════════════════════════════════════════════

map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- ═══════════════════════════════════════════════════════════
-- FOLDING NAVIGATION (for code organization)
-- ═══════════════════════════════════════════════════════════

-- Close all folds except current one (great for focus)
map("n", "zv", "zMzvzz", { desc = "Close all folds except the current one" })

-- Smart fold navigation (closes current, opens next/previous)
map("n", "zj", "zcjzOzz", { desc = "Close current fold when open. Always open next fold." })
map("n", "zk", "zckzOzz", { desc = "Close current fold when open. Always open previous fold." })

-- ═══════════════════════════════════════════════════════════
-- UTILITY SHORTCUTS
-- ═══════════════════════════════════════════════════════════

-- Toggle line wrapping
map("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "Toggle Wrap", silent = true })

-- Fix spelling (picks first suggestion)
map("n", "z0", "1z=", { desc = "Fix word under cursor" })
-- Select all content
map("n", "==", "gg<S-v>G")
map("n", "<A-a>", "ggVG", { noremap = true, silent = true, desc = "Select all" })

keymap("n", "<F2>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
keymap("n", "<F3>", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
keymap("n", "<F4>", "<cmd>Telescope oldfiles<cr>", { desc = "Live grep" })

-- keymap("n", "<F3>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
-- keymap("n", "<F4>", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
