-- Override Mason to prevent clangd installation issues
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Remove clangd from ensure_installed to avoid CUDA compilation issues
      opts.ensure_installed = vim.tbl_filter(function(pkg)
        return pkg ~= "clangd"
      end, opts.ensure_installed)
      return opts
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      -- Remove clangd from ensure_installed
      opts.ensure_installed = vim.tbl_filter(function(pkg)
        return pkg ~= "clangd"
      end, opts.ensure_installed)
      return opts
    end,
  },
}