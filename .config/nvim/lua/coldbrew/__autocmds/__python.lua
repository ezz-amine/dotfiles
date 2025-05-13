local autocmd = vim.api.nvim_create_autocmd

-- autoformat post save *.py
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = "*.py",
--   callback = function()
--     vim.lsp.buf.format({ async = false })
--   end
-- })
