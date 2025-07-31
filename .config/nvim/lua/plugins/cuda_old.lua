return {
  -- CUDA syntax highlighting and file type detection
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "cuda", "cpp" })
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      
      vim.filetype.add({
        extension = {
          cu = "cuda",
          cuh = "cuda",
        },
      })
    end,
  },

  -- Enhanced clangd setup with CUDA support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              ".clangd",
              ".clang-tidy",
              ".clang-format",
              "compile_commands.json",
              "compile_flags.txt",
              "configure.ac",
              ".git"
            )(fname)
          end,
        },
      },
    },
  },

  -- Create .clangd config file for comprehensive CUDA support
  {
    "nvim-lua/plenary.nvim",
    config = function()
      local config_path = vim.fn.stdpath("config")
      local cuda_headers_path = config_path .. "/cuda_headers"
      local clangd_config = config_path .. "/.clangd"
      
      -- Get the actual config path (current working directory)
      local actual_config_path = vim.fn.getcwd()
      local actual_cuda_headers = actual_config_path .. "/cuda_headers"
      
      -- Create comprehensive .clangd configuration
      local clangd_content = string.format([[
CompileFlags:
  Add: 
    - -I%s
    - -I%s/Common
    - -x
    - cuda
    - --cuda-device-only
    - --cuda-gpu-arch=sm_75
    - -std=c++17
    - -D__CUDACC__
    - -D__NVCC__
    - -D__CUDA_ARCH__=750
    - -DCUDA_VERSION=12060
    - -include
    - cuda_runtime_api.h
    - -include 
    - device_launch_parameters.h
  Remove: 
    - -W*
    - -fcuda-*

Diagnostics:
  Suppress: 
    - unknown-cuda-version
]], actual_cuda_headers, actual_cuda_headers)
      
      local file = io.open(clangd_config, "w")
      if file then
        file:write(clangd_content)
        file:close()
      end
      
      -- Add PATH for mock nvcc if it exists
      local nvcc_path = cuda_headers_path .. "/nvcc"
      if vim.fn.executable(nvcc_path) == 1 then
        vim.env.PATH = cuda_headers_path .. ":" .. vim.env.PATH
      end
    end,
  },
}
