return function(opts)
  local lspconfig = vim.tbl_get(opts, "lspconfig") or nil
  local cmp = vim.tbl_get(opts, "cmp") or nil
  -- local capabilities = vim.tbl_get(opts, "capabilities") or nil
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  if lspconfig ~= nil then
    local base_on_attach = vim.lsp.config.eslint.on_attach
    lspconfig.eslint.setup({
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        -- vim.keymap.set('n', '<leader>jf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format JSON' })
        if not base_on_attach then
          return
        end

        base_on_attach(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "LspEslintFixAll",
        })
      end,
    })
  end
end
