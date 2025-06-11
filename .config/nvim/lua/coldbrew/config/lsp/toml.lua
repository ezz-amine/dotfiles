return function(opts)
  local lspconfig = vim.tbl_get(opts, "lspconfig") or nil
  local cmp = vim.tbl_get(opts, "cmp") or nil
  local capabilities = vim.tbl_get(opts, "capabilities") or nil

  if lspconfig ~= nil then
    lspconfig.taplo.setup({
      capabilities = capabilities,
      -- on_attach = function(client, bufnr)
      --   vim.keymap.set('n', '<leader>tf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format TOML' })
      -- end,
    })
  end
end
