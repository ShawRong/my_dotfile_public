-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Performance optimizations
vim.opt.updatetime = 100 -- Faster completion and diagnostics
vim.opt.timeoutlen = 300 -- Faster key mapping timeout
vim.opt.redrawtime = 1500 -- Max time for syntax highlighting
vim.opt.synmaxcol = 200 -- Max column for syntax highlighting (performance)
vim.opt.lazyredraw = true -- Don't redraw during macros

-- Memory optimizations
vim.opt.maxmempattern = 1000 -- Max memory for pattern matching
vim.opt.history = 100 -- Limit command history
vim.opt.undolevels = 200 -- Limit undo levels

-- Reduce swapfile writes for performance
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Faster file operations
vim.opt.fsync = false

-- Disable some heavy features if not needed
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- LSP optimizations
vim.lsp.set_log_level("ERROR") -- Reduce LSP logging
