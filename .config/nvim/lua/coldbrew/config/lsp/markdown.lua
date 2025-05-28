return function(opts)
  local lspconfig = vim.tbl_get(opts, "lspconfig") or nil
  local cmp = vim.tbl_get(opts, "cmp") or nil
  local capabilities = vim.tbl_get(opts, "capabilities") or nil

  if lspconfig ~= nil then
    lspconfig.marksman.setup({
      capabilities = capabilities,
    })
  end

  if cmp ~= nil then
    cmp.setup.filetype('markdown', {
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'parrot' },
        { name = 'render-markdow' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      })
    })
  end
end
