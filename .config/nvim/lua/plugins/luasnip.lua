-- Minimal LuaSnip setup - only load essential snippets
return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter", -- Only load when entering insert mode
  dependencies = {
    {
      "rafamadriz/friendly-snippets",
      config = function()
        -- Only load essential language snippets
        require("luasnip.loaders.from_vscode").lazy_load({
          include = { "lua", "javascript", "typescript", "python", "rust", "c", "cpp" }
        })
        -- Load custom snippets if they exist
        local custom_snippets = vim.fn.stdpath("config") .. "/lua/luasnippets"
        if vim.fn.isdirectory(custom_snippets) == 1 then
          require("luasnip.loaders.from_lua").load({ paths = "./lua/luasnippets" })
        end
      end,
    },
  },
}
