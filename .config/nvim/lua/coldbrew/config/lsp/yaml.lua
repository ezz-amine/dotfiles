return function(opts)
  local lspconfig = vim.tbl_get(opts, "lspconfig") or nil
  local cmp = vim.tbl_get(opts, "cmp") or nil
  local capabilities = vim.tbl_get(opts, "capabilities") or nil

  if lspconfig ~= nil then
    lspconfig.yamlls.setup({
      capabilities = capabilities,
      -- on_attach = function(client, bufnr)
      --   vim.keymap.set('n', '<leader>yf', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format YAML' })
      -- end,
      settings = {
        yaml = {
          schemas = {
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = {
              "docker-compose.yml",
              "podman-compose.yml",
            },
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.32.1-standalone-strict/all.json"] =
            "/*.k8s.yaml",
          },
          hover = true,
          completion = true,
          validate = true,
        },
      },
    })
  end
end
