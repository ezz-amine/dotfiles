return {
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    config = function()
      require('mini.pairs').setup(cb_config("mini").pairs)
    end
  }
}
