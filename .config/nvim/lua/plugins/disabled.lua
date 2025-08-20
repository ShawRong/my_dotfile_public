-- Disable heavy/unnecessary plugins for better performance
return {
  -- Disable AI integrations completely
  { "yetone/avante.nvim", enabled = false },
  { "Bryley/neoai.nvim", enabled = false },
  { "CopilotC-Nvim/CopilotChat.nvim", enabled = false },
  { "zbirenbaum/copilot.lua", enabled = false },
  { "github/copilot.vim", enabled = false },
  { "Exafunction/codeium.nvim", enabled = false },

  -- Disable heavy UI plugins
  { "folke/noice.nvim", enabled = false }, -- Heavy notification system
  { "rcarriga/nvim-notify", enabled = false }, -- Not essential
  { "folke/persistence.nvim", enabled = false }, -- Session management not needed
  
  -- Disable heavy markdown plugins
  { "iamcco/markdown-preview.nvim", enabled = false }, -- Heavy browser preview
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false }, -- Heavy rendering
  
  -- Disable image handling (memory intensive)
  { "HakonHarnes/img-clip.nvim", enabled = false },
  
  -- Disable some language-specific heavy plugins
  { "mfussenegger/nvim-dap", enabled = false }, -- Debugging not always needed
  { "rcarriga/nvim-dap-ui", enabled = false },
  { "theHamsta/nvim-dap-virtual-text", enabled = false },
  
  -- Disable project/session management (can be heavy)
  { "ahmedkhalf/project.nvim", enabled = false },
  { "folke/persistence.nvim", enabled = false },
  
  -- Keep essential ones but optimize them
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Reduce memory usage
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false, -- Disable for performance
      },
      -- Only install essential parsers
      ensure_installed = {
        "c", "cpp", "lua", "vim", "vimdoc", "query",
        "javascript", "typescript", "python", "rust",
        "json", "yaml", "toml", "markdown", "markdown_inline"
      },
      -- Disable some heavy features
      indent = { enable = false }, -- Can cause performance issues
      incremental_selection = { enable = false },
    },
  },
  
  -- Optimize telescope for performance
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        -- Reduce file preview size for performance
        file_preview_size = 0,
        -- Disable some heavy features
        file_ignore_patterns = {
          "%.git/.*",
          "node_modules/.*",
          "%.cache/.*",
          "build/.*",
          "dist/.*",
          "target/.*",
        },
      },
    },
  },
  
  -- Optimize completion for performance
  {
    "hrsh7th/nvim-cmp",
    opts = {
      performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 200,
        async_budget = 1,
        max_view_entries = 50, -- Limit completion entries
      },
      sources = {
        { name = "nvim_lsp", max_item_count = 50 },
        { name = "buffer", max_item_count = 20 },
        { name = "path", max_item_count = 20 },
        { name = "luasnip", max_item_count = 20 },
      },
    },
  },
}