return {
  -- Disable conform.nvim from enforcing line length
  {
    "stevearc/conform.nvim", 
    opts = function(_, opts)
      -- Disable formatters that enforce line length
      if opts.formatters_by_ft then
        for filetype, formatters in pairs(opts.formatters_by_ft) do
          if type(formatters) == "table" then
            -- Filter out formatters known to wrap lines
            opts.formatters_by_ft[filetype] = vim.tbl_filter(function(formatter)
              return not vim.tbl_contains({"prettier", "prettierd", "dprint"}, formatter)
            end, formatters)
          end
        end
      end
      
      -- Configure specific formatters to not wrap lines
      opts.formatters = opts.formatters or {}
      
      -- Prettier settings - disable print width enforcement
      opts.formatters.prettier = {
        prepend_args = {
          "--print-width", "999999",  -- Essentially unlimited
          "--prose-wrap", "never",    -- Never wrap prose
        },
      }
      
      opts.formatters.prettierd = {
        prepend_args = {
          "--print-width", "999999",
          "--prose-wrap", "never",
        },
      }
      
      -- Disable auto-format on save for problematic file types
      opts.format_on_save = function(bufnr)
        -- Get the file type
        local filetype = vim.bo[bufnr].filetype
        
        -- Don't auto-format files that commonly cause line wrapping issues
        if vim.tbl_contains({"markdown", "text", "txt"}, filetype) then
          return false
        end
        
        return { 
          timeout_ms = 500, 
          lsp_fallback = true,
        }
      end
      
      return opts
    end,
  },

  -- Configure LSP to not enforce line length
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Disable LSP formatting that might wrap lines
      if opts.servers then
        for server, config in pairs(opts.servers) do
          if type(config) == "table" then
            config.settings = config.settings or {}
            
            -- Disable line length enforcement for common LSPs
            if server == "tsserver" or server == "ts_ls" then
              config.settings.typescript = config.settings.typescript or {}
              config.settings.typescript.format = config.settings.typescript.format or {}
              config.settings.typescript.format.insertSpaceAfterSemicolonInForStatements = false
            elseif server == "eslint" then
              config.settings.eslint = config.settings.eslint or {}
              config.settings.eslint.format = false
            end
          end
        end
      end
      return opts
    end,
  },

  -- Disable treesitter auto-indenting that might cause issues
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.indent = opts.indent or {}
      opts.indent.enable = false  -- Disable treesitter-based indenting
      return opts
    end,
  },
}