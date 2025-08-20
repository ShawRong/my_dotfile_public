return {
  -- Disable heavy colorscheme plugins
  { "folke/tokyonight.nvim", enabled = false },
  { "catppuccin/nvim", enabled = false },
  { "ellisonleao/gruvbox.nvim", enabled = false },
  
  -- Use built-in colorscheme for better performance
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "habamax", -- Fast built-in colorscheme
    },
  },
}
