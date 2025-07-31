return {
  -- Completely disable conform.nvim format on save
  {
    "stevearc/conform.nvim",
    opts = {
      -- COMPLETELY disable format on save
      format_on_save = false,
      format_after_save = false,
      
      -- Disable all formatters
      formatters_by_ft = {},
      
      -- Override any existing formatters to do nothing
      formatters = {
        prettier = { command = "echo", args = {} },
        prettierd = { command = "echo", args = {} },
        dprint = { command = "echo", args = {} },
        eslint = { command = "echo", args = {} },
        clang_format = { command = "echo", args = {} },
      },
    },
  },

  -- Disable nvim-lint
  {
    "mfussenegger/nvim-lint",
    opts = {
      -- Disable all linters
      linters_by_ft = {},
    },
  },

  -- Disable LSP formatting completely
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Override LSP setup to disable formatting
      setup = {
        ["*"] = function(server, opts)
          -- Disable formatting capability for ALL LSP servers
          if opts.capabilities then
            opts.capabilities.textDocument = opts.capabilities.textDocument or {}
            opts.capabilities.textDocument.formatting = false
            opts.capabilities.textDocument.rangeFormatting = false
          end
          return true
        end,
      },
    },
  },
}