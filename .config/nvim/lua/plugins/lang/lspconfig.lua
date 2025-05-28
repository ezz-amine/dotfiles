return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "nvimtools/none-ls.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      cb_config("lsp")
      local lspconfig = require("lspconfig")
      local cmp = require("cmp")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local opts = {
        lspconfig = lspconfig,
        cmp = cmp,
        capabilities = capabilities,
      }
      local langs = {
        -- "python",
        -- "js-ts", -- web
        "lua",
        "markdown",
      }
      vim.lsp.set_log_level("debug") -- helpful for troubleshooting
      for _, lang in ipairs(langs) do
        cb_lsp(lang)(opts)
      end
    end,
  },
}
