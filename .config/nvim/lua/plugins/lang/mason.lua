local config = cb_config("mason")

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      local mason_registry = require("mason-registry")

      for _, tool in ipairs(config.ensure_installed) do
        if not mason_registry.is_installed(tool) then
          mason_registry.get_package(tool):install()
        end
      end
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      -- require("mason").setup()
      require("mason-lspconfig").setup(config.lspconfig)
    end,
  }

}
