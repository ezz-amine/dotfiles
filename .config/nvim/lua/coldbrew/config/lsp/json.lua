return function(opts)
  local lspconfig = vim.tbl_get(opts, "lspconfig") or nil
  local cmp = vim.tbl_get(opts, "cmp") or nil
  -- local capabilities = vim.tbl_get(opts, "capabilities") or nil
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  if lspconfig ~= nil then
    lspconfig.jsonls.setup({
      capabilities = capabilities,
      -- on_attach = function(client, bufnr)
      --   vim.keymap.set('n', '<leader>jf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format JSON' })
      -- end,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
  end
end
