return function(opts)
  local lspconfig = vim.tbl_get(opts, "lspconfig") or nil
  local cmp = vim.tbl_get(opts, "cmp") or nil
  local capabilities = vim.tbl_get(opts, "capabilities") or nil

  if lspconfig ~= nil then
    lspconfig.bashls.setup({
      capabilities = capabilities,
    })
    lspconfig.fish_lsp.setup({
      capabilities = capabilities,
    })
  end
end
