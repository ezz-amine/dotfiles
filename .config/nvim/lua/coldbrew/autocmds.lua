-- Auto commands
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 300 })
  end,
})

-- Auto create directories when saving
autocmd("BufWritePre", {
  callback = function(ctx)
    local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
    vim.fn.mkdir(dir, "p")
  end,
})

-- autoformat post save *.py
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.py',
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})