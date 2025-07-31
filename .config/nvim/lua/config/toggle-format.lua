-- Toggle auto-formatting on/off

local M = {}

-- State tracking
M.auto_format_enabled = false

function M.toggle_auto_format()
  M.auto_format_enabled = not M.auto_format_enabled
  
  if M.auto_format_enabled then
    -- Enable auto-formatting
    vim.notify("✅ Auto-formatting ENABLED", vim.log.levels.INFO)
    
    -- Re-enable conform.nvim
    local conform = require("conform")
    conform.setup({
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
    
  else
    -- Disable auto-formatting
    vim.notify("❌ Auto-formatting DISABLED", vim.log.levels.WARN)
    
    -- Disable conform.nvim
    local conform = require("conform")
    conform.setup({
      format_on_save = false,
    })
    
    -- Force disable wrapping settings
    vim.bo.textwidth = 0
    vim.bo.wrapmargin = 0
    vim.bo.formatoptions = vim.bo.formatoptions:gsub("[tcawl]", "") .. "qj"
  end
end

function M.disable_format_current_buffer()
  vim.bo.textwidth = 0
  vim.bo.wrapmargin = 0 
  vim.bo.formatoptions = vim.bo.formatoptions:gsub("[tcawl]", "") .. "qj"
  vim.notify("🚫 Line wrapping disabled for current buffer", vim.log.levels.INFO)
end

-- Commands
vim.api.nvim_create_user_command("ToggleFormat", M.toggle_auto_format, {})
vim.api.nvim_create_user_command("DisableWrap", M.disable_format_current_buffer, {})
vim.api.nvim_create_user_command("NoWrap", M.disable_format_current_buffer, {})

-- Keymaps
vim.keymap.set("n", "<leader>tf", M.toggle_auto_format, { desc = "Toggle auto-formatting" })
vim.keymap.set("n", "<leader>tw", M.disable_format_current_buffer, { desc = "Disable line wrapping" })

-- Initialize with formatting disabled
M.auto_format_enabled = false

return M