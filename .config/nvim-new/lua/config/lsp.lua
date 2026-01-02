vim.lsp.enable({
  "clangd",     -- C / C++
  "pyright",    -- Python
  "lua_ls",     -- Lua
  "texlab",     -- LaTeX
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
