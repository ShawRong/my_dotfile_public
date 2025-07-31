-- Function parameter completion guide and customization

local M = {}

-- How to use function parameter snippets properly
function M.show_snippet_help()
  local help_text = [[
🎯 HOW TO USE FUNCTION PARAMETER SNIPPETS:

When you see: cudaMalloc(&devPtr, size)
                      ^^^^^^   ^^^^
                   placeholder1  placeholder2

✅ CORRECT WAY:
1. Accept completion (Tab/Enter)
2. Type your actual parameter: my_ptr
3. Press Tab → jumps to next placeholder  
4. Type next parameter: 1024
5. Press Tab → jumps out of function

❌ WRONG WAY:
- Manually delete the placeholders
- Use arrow keys to navigate

🔧 KEYBINDINGS:
- Tab       → Next placeholder
- Shift+Tab → Previous placeholder  
- Ctrl+C    → Cancel snippet mode
- Escape    → Exit snippet mode

📝 EXAMPLE:
Type: cudaMalloc  → Accept completion
Shows: cudaMalloc(&devPtr, size)
Type: &my_data    → Replaces &devPtr
Press: Tab        → Jumps to size
Type: 1024        → Replaces size
Press: Tab        → Exits snippet, cursor after )

💡 TIP: Let Tab do the navigation, don't delete manually!
]]
  
  vim.notify(help_text, vim.log.levels.INFO, { title = "Snippet Help" })
  return help_text
end

-- Configure snippet behavior
function M.setup_snippet_behavior()
  local luasnip = require("luasnip")
  
  -- Better snippet navigation keymaps
  vim.keymap.set({"i", "s"}, "<Tab>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      return "<Tab>"
    end
  end, {expr = true, desc = "Expand or jump to next snippet placeholder"})

  vim.keymap.set({"i", "s"}, "<S-Tab>", function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      return "<S-Tab>"
    end
  end, {expr = true, desc = "Jump to previous snippet placeholder"})

  -- Quick exit snippet mode
  vim.keymap.set({"i", "s"}, "<C-c>", function()
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    else
      luasnip.unlink_current()
      return "<C-c>"
    end
  end, {expr = true, desc = "Exit snippet mode"})

  -- Visual indicator when in snippet mode
  vim.keymap.set({"i", "s"}, "<C-l>", function()
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    end
  end, {desc = "Cycle through snippet choices"})
end

-- Configure completion to show fewer parameters or disable snippets
function M.configure_completion_style()
  local cmp = require("cmp")
  
  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    
    -- Customize how completion items look
    formatting = {
      format = function(entry, vim_item)
        -- Show function signatures without full snippet expansion
        if vim_item.kind == "Function" and entry.source.name == "nvim_lsp" then
          -- Optionally truncate long parameter lists
          if vim_item.menu and string.len(vim_item.menu) > 50 then
            vim_item.menu = string.sub(vim_item.menu, 1, 47) .. "..."
          end
        end
        
        return vim_item
      end,
    },
    
    -- Custom key mappings for completion
    mapping = cmp.mapping.preset.insert({
      ["<Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require("luasnip")
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, {"i", "s"}),
      
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require("luasnip")
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {"i", "s"}),
      
      -- Accept completion but don't expand snippet
      ["<C-y>"] = cmp.mapping.confirm({ 
        select = true,
        behavior = cmp.ConfirmBehavior.Replace 
      }),
      
      -- Accept completion and expand snippet
      ["<CR>"] = cmp.mapping.confirm({ 
        select = true,
        behavior = cmp.ConfirmBehavior.Insert 
      }),
    }),
  })
end

-- Commands to toggle snippet behavior
function M.disable_snippets()
  local cmp = require("cmp")
  cmp.setup({
    snippet = {
      expand = function(args)
        -- Don't expand, just insert the function name
        vim.api.nvim_put({args.body:match("^[^(]*")}, "c", true, true)
      end,
    },
  })
  vim.notify("📝 Snippets disabled - only function names will be inserted", vim.log.levels.INFO)
end

function M.enable_snippets()
  local cmp = require("cmp")
  cmp.setup({
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
  })
  vim.notify("✨ Snippets enabled - parameters will be shown", vim.log.levels.INFO)
end

-- Initialize
function M.init()
  M.setup_snippet_behavior()
  
  -- Create commands
  vim.api.nvim_create_user_command("SnippetHelp", M.show_snippet_help, {})
  vim.api.nvim_create_user_command("DisableSnippets", M.disable_snippets, {})
  vim.api.nvim_create_user_command("EnableSnippets", M.enable_snippets, {})
  
  -- Keymap to show help
  vim.keymap.set("n", "<leader>sh", M.show_snippet_help, { desc = "Show snippet help" })
  vim.keymap.set("n", "<leader>sd", M.disable_snippets, { desc = "Disable snippets" })
  vim.keymap.set("n", "<leader>se", M.enable_snippets, { desc = "Enable snippets" })
end

return M