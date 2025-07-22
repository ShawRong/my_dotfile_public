return {
  -- CUDA syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "cuda", "cpp" },
    },
  },

  -- File type detection for CUDA files
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      vim.filetype.add({
        extension = {
          cu = "cuda",
          cuh = "cuda",
        },
      })
    end,
  },

  -- Basic clangd setup (minimal CUDA support)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
      },
    },
  },
}
