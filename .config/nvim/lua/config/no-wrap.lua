-- Disable ONLY automatic line splitting/wrapping, keep other formatting

-- Disable automatic line wrapping but keep visual settings flexible
vim.opt.textwidth = 0         -- Disable automatic text wrapping at column limit
vim.opt.wrapmargin = 0        -- Disable wrapping based on terminal width

-- Remove only the problematic formatoptions that cause line splitting
vim.opt.formatoptions = vim.opt.formatoptions
  - "t"    -- Don't auto-wrap text using textwidth
  - "c"    -- Don't auto-wrap comments using textwidth  
  - "a"    -- Don't auto-format paragraphs
  - "w"    -- Don't use trailing whitespace to indicate paragraph continues
  - "l"    -- Don't break long lines in insert mode

-- Keep useful formatting options
vim.opt.formatoptions = vim.opt.formatoptions
  + "q"    -- Allow formatting of comments with "gq"
  + "j"    -- Remove comment leader when joining lines
  + "r"    -- Auto-insert comment leader on <Enter> in insert mode (keep this)
  + "o"    -- Auto-insert comment leader with 'o' and 'O' commands (keep this)

-- Keep indenting features (these are useful for code)
vim.opt.autoindent = true     -- Copy indent from current line when starting new line
vim.opt.smartindent = true    -- Smart autoindenting for C-like languages
vim.opt.cindent = true        -- Use C-style indenting

print("✅ Auto line-splitting disabled! Formatting and indenting kept.")