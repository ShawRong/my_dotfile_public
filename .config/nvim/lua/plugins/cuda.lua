return {
  -- CUDA treesitter support
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "cuda", "cpp", "c" })
    end,
  },

  -- CUDA file type detection and LSP autostart
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.filetype.add({
        extension = {
          cu = "cuda",
          cuh = "cuda",
        },
      })
      
      -- Autocommand to start clangd for CUDA files with global headers
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cuda",
        callback = function(args)
          local bufnr = args.buf
          local current_dir = vim.fn.getcwd()
          
          -- Check if clangd is already attached
          local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })
          if #clients > 0 then
            return
          end
          
          -- Auto-create .clangd if it doesn't exist
          local clangd_file = current_dir .. "/.clangd"
          if vim.fn.filereadable(clangd_file) == 0 then
            local home = vim.fn.expand("~")
            local template_path = home .. "/.local/include/cuda/.clangd-template"
            
            if vim.fn.filereadable(template_path) == 1 then
              -- Read template and replace ${HOME}
              local template = vim.fn.readfile(template_path)
              local content = {}
              for _, line in ipairs(template) do
                local processed_line = line:gsub("${HOME}", home)
                table.insert(content, processed_line)
              end
              
              -- Write .clangd file
              vim.fn.writefile(content, clangd_file)
              print("📄 Created .clangd file for CUDA autocompletion")
            end
          end
          
          -- Start clangd manually for CUDA files (use system clangd)
          vim.lsp.start({
            name = "clangd",
            cmd = {
              "/usr/bin/clangd",  -- Use system clangd to avoid Mason CUDA issues
              "--background-index",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=llvm",
            },
            filetypes = { "cuda" },
            root_dir = vim.fs.dirname(vim.fs.find({".clangd", ".clang-format", ".git"}, { upward = true })[1]) or current_dir,
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
          }, {
            bufnr = bufnr,
          })
        end,
      })
    end,
  },

  -- Disable Mason clangd installation to avoid CUDA issues
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

  -- LSP configuration for CUDA - override LazyVim clangd extra
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure clangd server config exists and force system clangd
      opts.servers = opts.servers or {}
      opts.servers.clangd = vim.tbl_deep_extend("force", opts.servers.clangd or {}, {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        cmd = {
          "/usr/bin/clangd",  -- Force system clangd
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
      })
      return opts
    end,
  },
}