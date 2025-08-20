-- Minimal CUDA support - only basic file type detection
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Only add cuda parser if needed
      opts.ensure_installed = opts.ensure_installed or {}
      if vim.fn.executable("nvcc") == 1 then
        vim.list_extend(opts.ensure_installed, { "cuda" })
      end
    end,
  },

  -- Simple CUDA file type detection
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.filetype.add({
        extension = {
          cu = "cuda",
          cuh = "cuda",
        },
      })
    end,
  },
}