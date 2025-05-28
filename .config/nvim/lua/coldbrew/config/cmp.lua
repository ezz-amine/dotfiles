local M = {}

function M.main_config(opts)
  local cmp = vim.tbl_get(opts, "cmp") or nil
  local luasnip = vim.tbl_get(opts, "luasnip") or nil

  if cmp == nil or luasnip == nil then
    return {}
  end

  return {
    enabled = true,
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<Up>"] = cmp.mapping.abort(),
      ["<Down>"] = cmp.mapping.abort(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<M-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
      { name = 'parrot' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    }, {
      { name = 'path' },
    }),
  }
end

function M.cmdline_config(opts)
  local cmp = vim.tbl_get(opts, "cmp") or nil

  return {
    [{ '/', '?' }] = {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
      ,
    },
    [':'] = {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources(
        {
          { name = 'path' }
        },
        {
          { name = 'cmdline' }
        }
      ),
      matching = { disallow_symbol_nonprefix_matching = false }
    }
  }
end

M.luasnip_path = {
  vim.fs.normalize(vim.fn.stdpath('config') .. '/lua/coldbrew/snippets')
}

return M
