# Neovim Configuration Overview

This is a modular and modern Neovim configuration written in Lua, featuring a custom plugin management system and comprehensive development tool integration.

## Architecture

The configuration is structured as follows:

*   `init.lua`: Main entry point, requiring `config` and `plugins` modules.
*   `lua/config/`: Core configuration files.
    *   `options.lua`: Global Neovim options (`number`, `relativenumber`, `tabstop`, etc.).
    *   `keymaps.lua`: General keybindings (buffer switching, window navigation, file operations).
    *   `autocmds.lua`: Event-driven behaviors (highlight on yank, auto-creating directories on save).
    *   `lsp.lua`: Language Server Protocol (LSP) configuration for `clangd`, `pyright`, `lua_ls`, and `texlab`.
    *   `diagnostics.lua`: UI settings for LSP diagnostics.
*   `lua/plugins/`: Individual plugin configurations.
    *   Each file typically contains a `vim.pack.add({...})` call followed by plugin-specific setup.
*   `ftplugin/`: Filetype-specific settings and keybindings (e.g., `<F5>` for running Python/C code).
*   `lsp/`: Custom LSP handler configurations (e.g., `clangd.lua`, `lua_ls.lua`).

## Plugin Management

This configuration uses a non-standard `vim.pack` API for plugin management, which tracks dependencies in `nvim-pack-lock.json`.

*   **Plugins are declared** in `lua/plugins/*.lua` using `vim.pack.add`.
*   **Lockfile:** `nvim-pack-lock.json` stores the exact revisions and sources for all installed plugins.
*   **Key Plugins:**
    *   `blink.cmp`: Blazing fast completion engine.
    *   `conform.nvim`: Lightweight formatter (configured in `lua/plugins/conform.lua`).
    *   `snacks.nvim`: A collection of small, useful Neovim utilities.
    *   `telescope.nvim`: Fuzzy finder for files, grep, and more.
    *   `nvim-treesitter`: Advanced syntax highlighting and code analysis.
    *   `which-key.nvim`: Keybinding popup and documentation.
    *   `noice.nvim`: Enhanced UI for messages, cmdline, and popupmenu.

## Development Workflows

### Building and Running
*   **Python:** Press `<F5>` in a `.py` file to save and execute it.
*   **C/C++:** Press `<F5>` in a `.c`/`.cpp` file to run `make` and open the quickfix list.
*   **LSP Features:**
    *   `<leader>h`: Switch between source and header in C/C++.
    *   Diagnostics are displayed inline via virtual text.

### Keymaps to Note
*   `<leader>` is set to `<Space>`.
*   `<Tab>` / `<S-Tab>`: Cycle through open buffers.
*   `<C-h/j/k/l>`: Move between windows.
*   `<C-s>`: Save file in any mode.
*   `gh` / `gl`: Go to start/end of line.
*   `<F2>`: Find files (Telescope).
*   `<F3>`: Live grep (Telescope).

## Development Conventions

*   **Modularity:** Keep plugin-specific configurations in `lua/plugins/`.
*   **Autocommands:** Use the `user_<name>` augroup naming convention as defined in `lua/config/autocmds.lua`.
*   **Formatting:** Use `conform.nvim` for consistent formatting across different filetypes.
*   **Keymaps:** Prefer `vim.keymap.set` and always provide a `desc` for `which-key` integration.
