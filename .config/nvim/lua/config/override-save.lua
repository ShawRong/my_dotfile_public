-- Override save commands to prevent any formatting

local original_write = vim.api.nvim_command

-- Create a custom write function that bypasses all formatting
local function write_without_format()
  -- Temporarily disable all autocommands
  vim.cmd("noautocmd write")
end

-- Override common save commands
vim.keymap.set("n", "<C-s>", write_without_format, { desc = "Save without formatting" })
vim.keymap.set("i", "<C-s>", "<Esc>:noautocmd write<CR>", { desc = "Save without formatting" })

-- Create commands for safe saving
vim.api.nvim_create_user_command("W", "noautocmd write", {})
vim.api.nvim_create_user_command("Wq", "noautocmd write | quit", {})
vim.api.nvim_create_user_command("WQ", "noautocmd write | quit", {})

-- Also override the standard :w command
vim.api.nvim_create_user_command("WriteNoFormat", "noautocmd write", {})

print("💾 Custom save commands loaded - use :W or Ctrl+S to save without formatting")