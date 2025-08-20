-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Load custom configurations only if they exist
local function safe_require(module)
  local ok, _ = pcall(require, module)
  if not ok then
    -- Module doesn't exist, skip silently
  end
end

-- Only load existing configuration modules
safe_require("config.no-wrap")
safe_require("config.toggle-format")
safe_require("config.override-save")

-- Performance optimizations
vim.opt.winblend = 0 -- Disable window transparency
vim.opt.pumblend = 0 -- Disable popup menu transparency  
vim.opt.cursorline = false -- Disable cursor line highlight for better performance
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
