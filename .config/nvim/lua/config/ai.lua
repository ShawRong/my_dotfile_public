-- AI Configuration for LazyVim
-- This file contains AI-related settings and utilities

local M = {}

-- Setup environment variables for AI services
function M.setup_env()
  -- Check for API keys
  local anthropic_key = os.getenv("ANTHROPIC_API_KEY")
  local openai_key = os.getenv("OPENAI_API_KEY")
  
  if not anthropic_key then
    vim.notify(
      "ANTHROPIC_API_KEY not found. Set it with: export ANTHROPIC_API_KEY='your-key'",
      vim.log.levels.WARN,
      { title = "Claude Setup" }
    )
  end
  
  if not openai_key then
    vim.notify(
      "OPENAI_API_KEY not found. Some AI features may not work.",
      vim.log.levels.INFO,
      { title = "AI Setup" }
    )
  end
end

-- AI-specific keymaps and commands
function M.setup_ai_keymaps()
  local wk = require("which-key")
  
  -- Avante AI keymaps
  wk.register({
    ["<leader>a"] = {
      name = "AI Assistant",
      a = { ":AvanteAsk<CR>", "Avante: Ask" },
      e = { ":AvanteEdit<CR>", "Avante: Edit" },
      r = { ":AvanteRefresh<CR>", "Avante: Refresh" },
      f = { ":AvanteFocus<CR>", "Avante: Focus" },
      s = { ":NeoAIToggle<CR>", "NeoAI: Toggle" },
      c = { ":NeoAIContext<CR>", "NeoAI: Context" },
      g = { function() vim.cmd("NeoAI gitcommit") end, "Generate Git Commit" },
    },
  })
  
  -- Visual mode keymaps
  wk.register({
    ["<leader>a"] = {
      name = "AI Assistant", 
      a = { ":AvanteAsk<CR>", "Ask about selection" },
      e = { ":AvanteEdit<CR>", "Edit selection" },
      s = { function() vim.cmd("NeoAI textify") end, "Fix text with AI" },
      r = { ":CopilotChatClaudeReview<CR>", "Review Selection" },
      x = { ":CopilotChatClaudeExplain<CR>", "Explain Selection" },
      o = { ":CopilotChatClaudeOptimize<CR>", "Optimize Selection" },
    },
  }, { mode = "v" })
end

-- Custom Claude prompts for different coding tasks
function M.get_prompts()
  return {
    code_review = [[
Please provide a comprehensive code review focusing on:

1. **Code Quality**: Best practices, style, and conventions
2. **Security**: Potential vulnerabilities or security issues  
3. **Performance**: Optimization opportunities and bottlenecks
4. **Maintainability**: Code clarity, documentation, and structure
5. **Testing**: Suggestions for test coverage and edge cases

Please be specific with examples and provide actionable feedback.
]],

    explain_code = [[
Please explain this code in detail, covering:

1. **Purpose**: What does this code accomplish?
2. **Logic Flow**: Step-by-step breakdown of the execution
3. **Key Concepts**: Important patterns, algorithms, or techniques used
4. **Dependencies**: External libraries or frameworks involved
5. **Use Cases**: When and where this code would be useful

Make the explanation clear for both beginners and experienced developers.
]],

    optimize_performance = [[
Please analyze this code for performance optimization opportunities:

1. **Algorithmic Complexity**: Can the time/space complexity be improved?
2. **Data Structures**: Are the most efficient data structures being used?
3. **Memory Usage**: Any memory leaks or unnecessary allocations?
4. **I/O Operations**: Can file/network operations be optimized?
5. **Concurrency**: Opportunities for parallelization or async operations?

Provide specific, implementable suggestions with code examples.
]],

    fix_bugs = [[
Please analyze this code for potential bugs and issues:

1. **Syntax Errors**: Any compilation or runtime errors
2. **Logic Errors**: Flawed algorithms or incorrect implementations  
3. **Edge Cases**: Unhandled scenarios that could cause failures
4. **Resource Management**: Memory leaks, file handle issues, etc.
5. **Type Safety**: Type mismatches or unsafe operations

Provide fixes with explanations of why the bugs occur.
]],

    add_documentation = [[
Please add comprehensive documentation to this code:

1. **Function/Class Documentation**: Purpose, parameters, return values
2. **Inline Comments**: Explain complex logic and algorithms
3. **Usage Examples**: How to use the code correctly
4. **API Documentation**: If applicable, document the public interface
5. **Error Handling**: Document what errors can occur and when

Follow the appropriate documentation standards for the language.
]],
  }
end

-- Initialize AI configuration
function M.init()
  M.setup_env()
  
  -- Setup keymaps after which-key is loaded
  vim.schedule(function()
    if pcall(require, "which-key") then
      M.setup_ai_keymaps()
    end
  end)
end

return M