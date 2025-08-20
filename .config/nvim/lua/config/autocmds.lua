-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
-- CUDA file settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cuda",
  callback = function()
    vim.bo.commentstring = "// %s"
    vim.bo.cindent = true
    vim.bo.filetype = "cuda"
  end,
})

-- Aggressively disable line wrapping for all file types
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "FileType"}, {
  pattern = "*",
  callback = function()
    -- Force disable text wrapping settings
    vim.bo.textwidth = 0
    vim.bo.wrapmargin = 0
    
    -- Remove problematic format options
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("[tcawl]", "")
    
    -- Ensure these are set
    if not vim.bo.formatoptions:find("q") then
      vim.bo.formatoptions = vim.bo.formatoptions .. "q"
    end
    if not vim.bo.formatoptions:find("j") then
      vim.bo.formatoptions = vim.bo.formatoptions .. "j"
    end
  end,
})

-- Disable LazyVim's auto-wrapping and formatting groups
vim.api.nvim_create_autocmd("User", {
  pattern = "LazyVimStarted",
  callback = function()
    pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_wrap_spell")
    pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_format_notify")
    pcall(vim.api.nvim_del_augroup_by_name, "LazyvimFormatNotify")
  end,
})

-- Disable any BufWritePre autocmds that might format
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Override any existing BufWritePre formatting
    -- Don't return false as it can cause issues
  end,
  priority = 1000, -- Higher priority to run first
})

-- Create our own formatting prevention group
local format_group = vim.api.nvim_create_augroup("NoAutoWrap", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = format_group,
  pattern = {"markdown", "text", "gitcommit"},
  callback = function()
    vim.bo.textwidth = 0
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("[tca]", "") .. "q"
  end,
})
