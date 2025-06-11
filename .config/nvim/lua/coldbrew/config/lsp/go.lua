return function(opts)
  local lspconfig = vim.tbl_get(opts, "lspconfig") or nil
  local cmp = vim.tbl_get(opts, "cmp") or nil
  local capabilities = vim.tbl_get(opts, "capabilities") or nil

  if lspconfig ~= nil then
    lspconfig.gopls.setup({
      capabilities = capabilities,
      settings = {
        gopls = {
          -- Enables all analyses. Set to false to selectively enable analyses.
          analyses = {
            -- Checks for unused parameters in functions. Helps keep your code clean.
            unusedparams = true,

            -- Checks for unused write operations to variables. Catches dead code.
            unusedwrite = true,

            -- Analyzes your code for potential panics from nil pointers. Very helpful!
            nilness = true,

            -- Checks for assignments to struct fields that are not used.
            unreachable = true,

            -- Suggests simplifying composite literals.
            simplifycompositelit = true,

            -- Suggests simplifying slice expressions.
            simplifyslice = true,
          },
          -- Allows for an experimental feature for inlay hints.
          experimentalPostfixCompletions = true,
          -- Automatically formats the code on save.
          gofumpt = true,
          -- Provides static analysis of Go programs.
          staticcheck = true,
        },
      },
    })
  end
end
