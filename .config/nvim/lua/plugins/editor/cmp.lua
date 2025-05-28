return {
  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "neovim/nvim-lspconfig",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local opts = { cmp = cmp, luasnip = require("luasnip") }
      local config = cb_config("cmp")

      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      -- Additional LuaSnip configuration can go here
      require("luasnip.loaders.from_lua").load({
        paths = config.luasnip_paths,
      })

      cmp.setup(config.main_config(opts))
      for key, value in pairs(config.cmdline_config(opts)) do
        cmp.setup.cmdline(key, value)
      end
    end,
  },

  -- Snippet engine (cross-platform version)
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- Optional: Only run the build command on Unix systems
    build = (function()
      if vim.g.is_windows then
        return nil
      else
        return "make install_jsregexp"
      end
    end)(),
  },
}
