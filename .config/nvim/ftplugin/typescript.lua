-- Set Python to use 4 spaces
vim.bo.tabstop = 4         -- How many columns a tab counts for
vim.bo.softtabstop = 4     -- Number of columns inserted with Tab
vim.bo.shiftwidth = 4      -- Number of columns for autoindent
vim.bo.expandtab = true    -- Convert tabs to spaces
vim.opt.smartindent = true -- Smart auto-indenting

-- Enable Tree-sitter based folding
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
