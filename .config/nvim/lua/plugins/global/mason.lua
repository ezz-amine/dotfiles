return {
  "williamboman/mason-lspconfig.nvim",
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        PATH = "prepend",
      })
    end
  }
}