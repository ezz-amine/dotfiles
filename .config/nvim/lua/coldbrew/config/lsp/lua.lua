return function(opts)
  local lspconfig = vim.tbl_get(opts, "lspconfig") or nil
  local cmp = vim.tbl_get(opts, "cmp") or nil
  local capabilities = vim.tbl_get(opts, "capabilities") or nil

  if lspconfig ~= nil then
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = { globals = { 'vim' } },
          telemetry = { enable = false },
        },
      },
    })
  end

  if cmp ~= nil then
    cmp.setup.filetype('lua', {
      sources = cmp.config.sources(
        {
          { name = 'nvim_lsp' },
          { name = 'parrot' },
          { name = 'lazydev' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        },
        {
          { name = 'cmdline' }
        }
      )
    })
  end
end
