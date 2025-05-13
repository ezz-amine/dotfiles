-- Set Python to use 4 spaces
vim.bo.tabstop = 4         -- How many columns a tab counts for
vim.bo.softtabstop = 4     -- Number of columns inserted with Tab
vim.bo.shiftwidth = 4      -- Number of columns for autoindent
vim.bo.expandtab = true    -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart auto-indenting

-- Enable Tree-sitter based folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Better syntax-aware text objects
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
vim.keymap.set("n", ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set("n", ",", ts_repeat_move.repeat_last_move_previous)

-- Jump between function/class definitions
vim.keymap.set("n", "]f", function()
  require("nvim-treesitter.textobjects.swap").goto_next_start("@function.outer")
end, { desc = "Next function" })

vim.keymap.set("n", "[f", function()
  require("nvim-treesitter.textobjects.swap").goto_prev_start("@function.outer")
end, { desc = "Prev function" })
