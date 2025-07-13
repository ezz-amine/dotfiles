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
      -- settings = {
      --   eslint = {
      --     format = {
      --       enable = true,
      --       indentStyle = "space",
      --     },
      --     validate = "on",
      --     workingDirectory = { mode = "auto" },
      --   },
      -- },
      settings = {
        -- packageManager = "npm",
        -- Point to your config explicitly if needed
        workingDirectory = { mode = "auto" },
        -- For monorepos or non-standard paths
        validate = "on",
        rulesCustomizations = {},
        run = "onType",
        nodePath = "",
        codeAction = {
          disableRuleComment = {
            enable = true,
            location = "separateLine",
          },
          showDocumentation = {
            enable = true,
          },
        },
        codeActionOnSave = {
          enable = false,
          mode = "all",
        },
        format = false,          -- Let other plugins handle formatting
        experimental = {
          useFlatConfig = false, -- Set true if using eslint.config.js
        },
        rulesCustomizations = {
          { rule = "indent", severity = "error", value = { 4, { SwitchCase = 1 } } },
        },
      },
      root_dir = require("lspconfig.util").root_pattern(
        ".eslintrc",
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.yml",
        ".eslintrc.yaml",
        "package.json",
        "eslint.config.js"
      ),
    })
  end
end
