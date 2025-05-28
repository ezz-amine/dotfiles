return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  config = function()
    require("lazydev").setup({})
  end
}
