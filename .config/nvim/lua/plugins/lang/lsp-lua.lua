return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
      },
    }
  },
  {
    "neovim/nvim-lspconfig",
    ft = "lua",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      -- none-ls
      local null_ls = require("null-ls")

      -- format-on-save
    end,
  },
}
