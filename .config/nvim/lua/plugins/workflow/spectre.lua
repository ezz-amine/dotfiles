local vars = require "coldbrew.vars"

return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("spectre").setup(cb_config "spectre")
  end,
}
