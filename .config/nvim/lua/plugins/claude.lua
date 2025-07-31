return {
  -- Avante.nvim - AI-powered code assistant with Claude support  
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        temperature = 0,
        max_tokens = 4096,
      },
      mappings = {
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
      },
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and variables
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers="copilot"
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    keys = {
      { "<leader>aa", ":AvanteAsk<CR>", desc = "Avante: Ask", mode = { "n", "v" } },
      { "<leader>ae", ":AvanteEdit<CR>", desc = "Avante: Edit", mode = { "v" } },
      { "<leader>ar", ":AvanteRefresh<CR>", desc = "Avante: Refresh" },
      { "<leader>af", ":AvanteFocus<CR>", desc = "Avante: Focus" },
    },
  },

  -- NeoAI - Alternative AI plugin with Claude support
  {
    "Bryley/neoai.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    keys = {
      { "<leader>as", ":NeoAIToggle<CR>", desc = "NeoAI: Toggle" },
      { "<leader>ac", ":NeoAIContext<CR>", desc = "NeoAI: Context" },
    },
    config = function()
      require("neoai").setup({
        -- Anthropic Claude configuration
        model = "claude-3-5-sonnet-20241022",
        open_ai = {
          api_key = {
            env = "ANTHROPIC_API_KEY",
            value = nil,
          },
          base_url = "https://api.anthropic.com/v1",
          headers = {
            ["anthropic-version"] = "2023-06-01",
          },
        },
        prompts = {
          context_prompt = function(context)
            return "Hey, I'd like to provide some context for future "
              .. "messages. Here is the code/text that I want to refer "
              .. "to in our conversation:\n\n"
              .. context
          end,
        },
        mappings = {
          ["select_up"] = "<C-k>",
          ["select_down"] = "<C-j>",
        },
        inject = {
          cutoff_width = 75,
        },
        shortcuts = {
          {
            name = "textify",
            key = "<leader>as",
            desc = "Fix text with AI",
            use_context = true,
            prompt = [[
              Please rewrite the text to make it more readable, clear,
              concise, and fix any grammar, spelling, or punctuation
              errors. Also try to improve the overall quality of the text.
            ]],
            modes = { "v" },
            strip_function = nil,
          },
          {
            name = "gitcommit", 
            key = "<leader>ag",
            desc = "Generate git commit message",
            use_context = false,
            prompt = function()
              return [[
                Using the following git diff generate a conventional commit message.
                Describe the change in one line. Try to summarize the intent of the change.
                Don't go over 80 characters total. Prefix one of the commit types like "feat:" or "fix:".
                
                ]] .. vim.fn.system("git diff --cached")
            end,
            modes = { "n" },
            strip_function = nil,
          },
        },
      })
    end,
  },

  -- Copilot Chat integration (already have copilot-chat extra)
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = function(_, opts)
      -- Enhance existing copilot chat with Claude-like prompts
      opts.prompts = vim.tbl_extend("force", opts.prompts or {}, {
        ClaudeReview = {
          prompt = "/COPILOT_REVIEW Please review the following code and provide detailed feedback on:\n1. Code quality and best practices\n2. Potential bugs or issues\n3. Performance optimizations\n4. Readability improvements\n\nSelected code:\n```$filetype\n$text\n```",
          mapping = "<leader>ccr",
          description = "Claude-style code review",
          selection = true,
        },
        ClaudeExplain = {
          prompt = "/COPILOT_EXPLAIN Please explain this code in detail, including:\n1. What it does\n2. How it works\n3. Key concepts used\n4. Potential use cases\n\n```$filetype\n$text\n```",
          mapping = "<leader>cce", 
          description = "Claude-style code explanation",
          selection = true,
        },
        ClaudeOptimize = {
          prompt = "/COPILOT_GENERATE Please optimize this code for better performance, readability, and maintainability:\n\n```$filetype\n$text\n```",
          mapping = "<leader>cco",
          description = "Claude-style code optimization",
          selection = true,
        },
      })
      return opts
    end,
  },
}