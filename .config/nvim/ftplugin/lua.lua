-- Override ALL possible indent sources
vim.bo.tabstop = 2
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.expandtab = true

-- Disable LSP formatting if conflicting
vim.b.disable_autoformat = true

-- Clear any filetype-specific indentexpr
vim.bo.indentexpr = ''

-- Force 2-space tabs even when paste mode is on
vim.api.nvim_create_autocmd('BufEnter', {
  buffer = 0,
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end
})
